#!/usr/bin/env bash
#MISE description="Build the documentation"

set -euo pipefail

### Variables ###
VERSION="${DOCS_VERSION:-latest}"
SCHEMES=("swiftui-theming")

DOCC_BUNDLE_PATH="./Sources/Documentation.docc"

DERIVED_DATA_DIR=".deriveddata"
BUILD_DIR="${PWD}/.build"
SYMBOL_GRAPHS_DIR="${BUILD_DIR}/symbol-graphs"

WEBSITE_OUTPUT_PATH="${PWD}/.docs-out"
FALLBACK_BUNDLE_IDENTIFIER="dev.alexanderweiss.swiftui_theming"
FALLBACK_DISPLAY_NAME="SwiftUITheming"
SITE_BASE_PATH="/swiftui-theming"
HOSTING_BASE_PATH="${SITE_BASE_PATH}/${VERSION}"
DOCCARCHIVE_PATH="${PWD}/${FALLBACK_DISPLAY_NAME}.doccarchive"

### Methods ###
build_for_platform() {
    local LOC_SYMBOL_GRAPHS_DIR=$1
    local LOC_DERIVED_DATA_DIR=$2
    local LOC_PLATFORM=$3
    local LOC_SCHEME=$4

    echo "  📂 SYMBOL_GRAPHS_DIR: ${LOC_SYMBOL_GRAPHS_DIR}"
    echo "  📂 DERIVED_DATA_DIR: ${LOC_DERIVED_DATA_DIR}"
    echo "  🎯 PLATFORM: ${LOC_PLATFORM}"
    echo "  📦 SCHEME: ${LOC_SCHEME}"

    mkdir -p "${LOC_SYMBOL_GRAPHS_DIR}"

    xcodebuild build \
        -scheme "${LOC_SCHEME}" \
        -destination "${LOC_PLATFORM}" \
        -derivedDataPath "${LOC_DERIVED_DATA_DIR}" \
        DOCC_EXTRACT_EXTENSION_SYMBOLS=YES \
        OTHER_SWIFT_FLAGS="-Xfrontend -emit-symbol-graph -Xfrontend -emit-symbol-graph-dir -Xfrontend ${LOC_SYMBOL_GRAPHS_DIR} -Xfrontend -emit-extension-block-symbols" | xcbeautify
}

platforms=(
    "iOS,📱"
    "watchOS,⌚"
    "visionOS,🕶️"
    "tvOS,📺"
    "macOS,💻"
)

# Iterate over available platforms
for SCHEME in "${SCHEMES[@]}"; do
    echo "Building documentation symbols for ${SCHEME}"
    for input in "${platforms[@]}"; do
        IFS="," read -r platform icon <<<"${input}"
        platform_symbol_graphs_dir="${SYMBOL_GRAPHS_DIR}/${SCHEME}/${platform}"
        echo "${icon} Building ${SCHEME} for ${platform}"
        build_for_platform \
            "${platform_symbol_graphs_dir}" \
            "${DERIVED_DATA_DIR}" \
            "generic/platform=${platform}" \
            "${SCHEME}"
    done
done

### Creating Archive ###
echo "📦 Creating .doccarchive"
# Create a .doccarchive from the combined symbol graphs.
xcrun docc convert "${DOCC_BUNDLE_PATH}" \
    --fallback-display-name "${FALLBACK_DISPLAY_NAME}" \
    --fallback-bundle-identifier "${FALLBACK_BUNDLE_IDENTIFIER}" \
    --fallback-bundle-version 1 \
    --output-dir "${DOCCARCHIVE_PATH}" \
    --additional-symbol-graph-dir "${SYMBOL_GRAPHS_DIR}" \
    --enable-experimental-markdown-output \
    --enable-experimental-markdown-output-manifest

### Processing Archive ###
echo "⚙️  Processing .doccarchive"
mkdir -p "${WEBSITE_OUTPUT_PATH}"
xcrun docc process-archive \
    transform-for-static-hosting "${DOCCARCHIVE_PATH}" \
    --output-path "${WEBSITE_OUTPUT_PATH}" \
    --hosting-base-path "${HOSTING_BASE_PATH}"

echo "🔧 Injecting version picker script"

PICKER_SCRIPT="<script defer src=\"${SITE_BASE_PATH}/version-picker.js\"></script>"

find "${WEBSITE_OUTPUT_PATH}" -name 'index.html' -exec \
    perl -pi -e "s|</body>|${PICKER_SCRIPT}</body>|" {} +

echo "${VERSION}" >"${WEBSITE_OUTPUT_PATH}/.docs-version"

echo "✅ Documentation built successfully (version: ${VERSION})"

# Clean up.
rm -rf "${DERIVED_DATA_DIR}"
rm -rf "${BUILD_DIR}"
