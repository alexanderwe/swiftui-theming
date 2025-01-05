import Theming

// MARK: - Available Themes
extension Theme {
    static let `default`: Theme = .createDefaultTheme()
}

// MARK: - Theme creation
extension Theme {
    private static func createDefaultTheme() -> Theme {
        let colors: Theme.ColorMap

        colors = [
            .primaryLabel: ThemeColor(lightColor: .primary, darkColor: .primary),
            .secondaryLabel: ThemeColor(lightColor: .gray, darkColor: .black),
            .tertiaryLabel: ThemeColor(lightColor: .primary, darkColor: .primary),
            .primaryBackground: ThemeColor(lightColor: .primary, darkColor: .primary),
            .primaryGroupedBackground: ThemeColor(lightColor: .primary, darkColor: .primary),
        ]
    }
}
