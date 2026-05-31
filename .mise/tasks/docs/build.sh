#!/usr/bin/env bash
#MISE description="Build the documentation"

SCHEMES=("swiftui-theming")
DOCC_BUNDLE_PATH="./Sources/Documentation.docc"

# Paths used in the script.
DERIVED_DATA_DIR=".deriveddata"
BUILD_DIR="${PWD}/.build"
SYMBOL_GRAPHS_DIR="${BUILD_DIR}/symbol-graphs"
SYMBOL_GRAPHS_DIR_IOS="${SYMBOL_GRAPHS_DIR}/ios"
SYMBOL_GRAPHS_DIR_WATCHOS="${SYMBOL_GRAPHS_DIR}/watchos"
SYMBOL_GRAPHS_DIR_VISIONOS="${SYMBOL_GRAPHS_DIR}/visionos"
SYMBOL_GRAPHS_DIR_TVOS="${SYMBOL_GRAPHS_DIR}/tvos"
SYMBOL_GRAPHS_DIR_MACOS="${SYMBOL_GRAPHS_DIR}/macos"
DOCCARCHIVE_PATH="${PWD}/${SCHEME}.doccarchive"
WEBSITE_OUTPUT_PATH="${PWD}/.docs-out"

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
    iOS,"📱","${SYMBOL_GRAPHS_DIR_IOS}"
    watchOS,"⌚","${SYMBOL_GRAPHS_DIR_WATCHOS}"
    visionOS,"🕶️","${SYMBOL_GRAPHS_DIR_VISIONOS}"
    tvOS,"📺","${SYMBOL_GRAPHS_DIR_TVOS}"
    macOS,"💻","${SYMBOL_GRAPHS_DIR_MACOS}"
)

# Iterate over available platforms
for input in "${platforms[@]}"; do
    # Split elements
    IFS=","
    set -- $input

    for scheme in "${SCHEMES[@]}"; do
        echo "$2 Building ${scheme} for $1"
        build_for_platform "$3" ${DERIVED_DATA_DIR} "generic/platform=$1" "${scheme}"
    done
done

echo "📦 Creating .doccarchive"
# Create a .doccarchive from the combined symbol graphs.
$(xcrun --find docc) convert "${DOCC_BUNDLE_PATH}" \
    --fallback-display-name "SwiftUITheming" \
    --fallback-bundle-identifier dev.alexanderweiss.swiftui_theming \
    --fallback-bundle-version 1 \
    --output-dir "${DOCCARCHIVE_PATH}" \
    --additional-symbol-graph-dir "${SYMBOL_GRAPHS_DIR}" \
    --enable-experimental-markdown-output \
    --enable-experimental-markdown-output-manifest

echo "⚙️  Processing .doccarchive"
mkdir -p "${WEBSITE_OUTPUT_PATH}"
$(xcrun --find docc) process-archive \
    transform-for-static-hosting "${DOCCARCHIVE_PATH}" \
    --output-path "${WEBSITE_OUTPUT_PATH}" \
    --hosting-base-path "/swiftui-theming/"

echo "✅ Documentation build successfully"

# Clean up.
rm -rf "${DERIVED_DATA_DIR}"
rm -rf "${BUILD_DIR}"
