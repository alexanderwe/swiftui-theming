#!/usr/bin/env bash
#MISE description="Deploy documentation to gh-pages branch"

set -euo pipefail

readonly DOCS_DIR="${PWD}/.docs-out"
readonly GH_PAGES_BRANCH="gh-pages"
readonly REMOTE="origin"
readonly ORIGINAL_DIR="${PWD}"

readonly SITE_BASE_PATH="/swiftui-theming"
readonly ASSETS_DIR="${PWD}/.mise/tasks/docs/assets"

WORKTREE_DIR=""

VERSION=$(cat "${DOCS_DIR}/.docs-version" 2>/dev/null || echo "latest")

cleanup_worktree() {
    if [[ -n "${WORKTREE_DIR}" && -d "${WORKTREE_DIR}" ]]; then
        cd "${ORIGINAL_DIR}"
        git worktree remove --force "${WORKTREE_DIR}" 2>/dev/null || true
        rm -rf "${WORKTREE_DIR}" 2>/dev/null || true
    fi
}

check_prerequisites() {
    if [[ ! -d "${DOCS_DIR}" ]]; then
        echo "❌ Error: ${DOCS_DIR} directory not found" >&2
        echo "Run the documentation build first." >&2
        exit 1
    fi

    if [[ ! -f "${DOCS_DIR}/index.html" ]]; then
        echo "❌ Error: ${DOCS_DIR} appears incomplete. No index.html found." >&2
        exit 1
    fi

    if [[ ! -f "${ASSETS_DIR}/version-picker.js" ]]; then
        echo "❌ Error: version-picker.js not found in ${ASSETS_DIR}" >&2
        exit 1
    fi

    if [[ ! -f "${ASSETS_DIR}/version-picker.css" ]]; then
        echo "❌ Error: version-picker.css not found in ${ASSETS_DIR}" >&2
        exit 1
    fi
}

ensure_gh_pages_branch_exists() {
    if git show-ref --verify --quiet "refs/heads/${GH_PAGES_BRANCH}"; then
        echo "ℹ️  Using existing local ${GH_PAGES_BRANCH} branch"
        return
    fi

    if git show-ref --verify --quiet "refs/remotes/${REMOTE}/${GH_PAGES_BRANCH}"; then
        echo "ℹ️  Fetching ${GH_PAGES_BRANCH} from ${REMOTE}"
        git fetch "${REMOTE}" "${GH_PAGES_BRANCH}:${GH_PAGES_BRANCH}"
        return
    fi

    echo "ℹ️  Creating new ${GH_PAGES_BRANCH} branch"

    git switch --orphan "${GH_PAGES_BRANCH}"
    git rm -rf . 2>/dev/null || true
    git commit --allow-empty -m "docs: initialize gh-pages branch"
    git push -u "${REMOTE}" "${GH_PAGES_BRANCH}"
    git switch -
}

update_versions_manifest() {
    local version="$1"
    local manifest="./versions.json"

    python3 - "$manifest" "$version" "$SITE_BASE_PATH" <<'PY'
import json
import re
import sys
from pathlib import Path

manifest_path = Path(sys.argv[1])
version = sys.argv[2]
site_base_path = sys.argv[3]

if manifest_path.exists():
    versions = json.loads(manifest_path.read_text())
else:
    versions = []

entry = {
    "version": version,
    "url": f"{site_base_path}/{version}/documentation/overview/"
}

versions = [item for item in versions if item["version"] != version]
versions.append(entry)

def sort_key(item):
    version = item["version"]

    if version == "latest":
        return (0, [])

    parts = [int(part) for part in re.findall(r"\d+", version)]
    return (1, [-part for part in parts])

versions.sort(key=sort_key)

manifest_path.write_text(json.dumps(versions, indent=2) + "\n")
PY
}

generate_root_redirect() {
    cat >./index.html <<EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="refresh" content="0; url=latest/documentation/overview/">
  <title>Redirecting...</title>
  <script>window.location.replace("latest/documentation/overview/");</script>
</head>
<body>
  <p>Redirecting to <a href="latest/documentation/overview/">latest documentation</a>...</p>
</body>
</html>
EOF
}

generate_404_page() {
    cat >./404.html <<EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Page Not Found</title>
  <script>
    var path = window.location.pathname;
    var base = '${SITE_BASE_PATH}/';

    if (path.startsWith(base)) {
      var rest = path.substring(base.length);

      if (rest && !rest.startsWith('latest/') && !/^\\d+\\.\\d+/.test(rest)) {
        window.location.replace(base + 'latest/' + rest);
      }
    }
  </script>
</head>
<body>
  <p>Page not found. <a href="${SITE_BASE_PATH}/latest/documentation/overview/">Go to documentation</a>.</p>
</body>
</html>
EOF
}

rewrite_base_path() {
    local dir="$1"
    local from_version="$2"
    local to_version="$3"

    echo "🔄 Rewriting base path from ${from_version} to ${to_version}"

    find "${dir}" -name 'index.html' -exec \
        perl -pi -e "s|\Q${SITE_BASE_PATH}/${from_version}/\E|${SITE_BASE_PATH}/${to_version}/|g" {} +
}

deploy_version() {
    local target_version="$1"

    echo "🧹 Cleaning ${target_version}/"
    rm -rf "./${target_version}"
    mkdir -p "./${target_version}"

    echo "📋 Copying documentation to ${target_version}/"
    cp -R "${DOCS_DIR}/." "./${target_version}/"
    rm -f "./${target_version}/.docs-version"

    if [[ "${target_version}" != "${VERSION}" ]]; then
        rewrite_base_path "./${target_version}" "${VERSION}" "${target_version}"
    fi

    echo "📝 Updating versions.json for ${target_version}"
    update_versions_manifest "${target_version}"
}

deploy_with_worktree() {
    WORKTREE_DIR=$(mktemp -d "${TMPDIR:-/tmp}/docc-gh-pages.XXXXXX")

    echo "📁 Creating temporary worktree at ${WORKTREE_DIR}"

    git worktree prune
    git worktree add --detach "${WORKTREE_DIR}" "${GH_PAGES_BRANCH}"

    cd "${WORKTREE_DIR}"

    if [[ ! -f ./versions.json ]]; then
        echo "🔄 Migrating to versioned documentation layout"
        find . -maxdepth 1 \
            -not -name '.git' \
            -not -name '.' \
            -not -name '..' \
            -exec rm -rf {} +
    fi

    deploy_version "${VERSION}"

    if [[ "${UPDATE_LATEST:-false}" == "true" && "${VERSION}" != "latest" ]]; then
        echo "🔄 Also updating latest/"
        deploy_version "latest"
    fi

    echo "📦 Updating shared assets"
    cp "${ASSETS_DIR}/version-picker.js" ./version-picker.js
    cp "${ASSETS_DIR}/version-picker.css" ./version-picker.css

    generate_root_redirect
    generate_404_page

    touch .nojekyll

    git add --all

    if git diff --quiet && git diff --cached --quiet; then
        echo "ℹ️  No changes to deploy"
        return 0
    fi

    SOURCE_COMMIT=$(git -C "${ORIGINAL_DIR}" rev-parse HEAD)

    echo "💾 Committing changes"
    git commit -m "docs: deploy ${VERSION} documentation from ${SOURCE_COMMIT}"

    echo "🚀 Pushing to ${REMOTE}/${GH_PAGES_BRANCH}"
    git push "${REMOTE}" "HEAD:${GH_PAGES_BRANCH}"
}

main() {
    echo "📚 Deploying documentation version ${VERSION} to ${GH_PAGES_BRANCH}"

    check_prerequisites
    ensure_gh_pages_branch_exists
    deploy_with_worktree
    cleanup_worktree

    echo "✅ Documentation deployed successfully"
}

trap cleanup_worktree EXIT ERR INT TERM

main
