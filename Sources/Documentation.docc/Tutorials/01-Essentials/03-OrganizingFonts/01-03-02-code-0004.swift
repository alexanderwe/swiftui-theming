import Theming

// MARK: - Available Themes
extension Theme {
    static let `default`: Theme = .createDefaultTheme()
}

// MARK: - Theme creation
extension Theme {
    private static func createDefaultTheme() -> Theme {
        // Color mapping
        let colors: Theme.ColorMap = // your color setup

            // Font mapping
            #if os(iOS) || os(visionOS)
            let fonts: Theme.FontMap = [
                ...,
            ]
            #elseif os(macOS)
            let fonts: Theme.FontMap = [
                ...,
            ]
            #elseif os(watchOS)
            let fonts: Theme.FontMap = [
                ...,
            ]
            #endif
    }
}
