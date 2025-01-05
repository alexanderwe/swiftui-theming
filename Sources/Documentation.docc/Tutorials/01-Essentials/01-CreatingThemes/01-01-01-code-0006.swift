import Theming

// MARK: - Available Themes
extension Theme {
    static let `default`: Theme = .createDefaultTheme()
}

// MARK: - Theme creation
extension Theme {
    private static func createDefaultTheme() -> Theme {
        let colors: Theme.ColorMap

        #if os(iOS) || os(visionOS)
        colors = [
            ...define iOS and visionOS color mappings,
        ]
        #elseif os(watchOS)
        colors = [
            ...define watchOS color mappings,
        ]
        #elseif os(macOS) || os(tvOS)
        colors = [
            ...define macOS and tvOS color mappings,
        ]
        #endif

        return Theme(name: "Default", colors: colors)
    }
}
