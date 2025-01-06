SCHEME="swiftui-theming"
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

  echo "SYMBOL_GRAPHS_DIR: ${LOC_SYMBOL_GRAPHS_DIR}"
  echo "DERIVED_DATA_DIR: ${LOC_DERIVED_DATA_DIR}"
  echo "PLATFORM: ${LOC_PLATFORM}"

  mkdir -p "${LOC_SYMBOL_GRAPHS_DIR}"
  xcodebuild build \
    -scheme "${SCHEME}" \
    -destination "${LOC_PLATFORM}" \
    -derivedDataPath "${LOC_DERIVED_DATA_DIR}" \
    DOCC_EXTRACT_EXTENSION_SYMBOLS=YES \
    OTHER_SWIFT_FLAGS="-Xfrontend -emit-symbol-graph -Xfrontend -emit-symbol-graph-dir -Xfrontend ${LOC_SYMBOL_GRAPHS_DIR} -Xfrontend -emit-extension-block-symbols" | xcbeautify
}

build_for_ios() {
  echo "📱 Building for iOS"
  build_for_platform ${SYMBOL_GRAPHS_DIR_IOS} ${DERIVED_DATA_DIR} "generic/platform=iOS"
}

build_for_watchos() {
  echo "⌚ Building for watchOS"
  build_for_platform ${SYMBOL_GRAPHS_DIR_WATCHOS} ${DERIVED_DATA_DIR}  "generic/platform=watchOS"
}

build_for_visionos() {
  echo "🕶️ Building for visionOS"
  build_for_platform ${SYMBOL_GRAPHS_DIR_VISIONOS} ${DERIVED_DATA_DIR} "generic/platform=visionOS"
}

build_for_tvos() {
  echo "📺 Building for tvOS"
  build_for_platform ${SYMBOL_GRAPHS_DIR_TVOS} ${DERIVED_DATA_DIR} "generic/platform=tvOS"
}

build_for_macos() {
  echo "💻 Building for macOS"
  build_for_platform ${SYMBOL_GRAPHS_DIR_MACOS} ${DERIVED_DATA_DIR} "generic/platform=macOS"
}

build_for_ios
build_for_watchos
build_for_visionos
build_for_tvos
build_for_macos

# Create a .doccarchive from the symbols.
$(xcrun --find docc) convert "${DOCC_BUNDLE_PATH}" \
  --fallback-display-name "${SCHEME}" \
  --fallback-bundle-identifier dev.alexanderweiss.swiftui_theming \
  --fallback-bundle-version 1 \
  --output-dir "${DOCCARCHIVE_PATH}" \
  --additional-symbol-graph-dir "${SYMBOL_GRAPHS_DIR}" \


mkdir -p "${WEBSITE_HOSTING_DATA}"
$(xcrun --find docc) process-archive \
transform-for-static-hosting "${DOCCARCHIVE_PATH}" \
--output-path "${WEBSITE_OUTPUT_PATH}" \
--hosting-base-path "/swiftui-theming/"

# Clean up.
rm -rf "${DERIVED_DATA_DIR}"
rm -rf "${BUILD_DIR}"
