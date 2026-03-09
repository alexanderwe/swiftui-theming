import Theming

// MARK: - Available Themes
extension Theme {
    static let `default`: Theme = .createDefaultTheme()
}

// MARK: - Previews
#Preview("Preview a theme", traits: .withTheme(.default)) {
    Text("Hello, World!")
        .foregroundStyle(.themeColor(for: .primaryLabel))
}

#Preview(
    "Preview a theme manager",
    traits: .withThemeManager(ThemeManager(initialTheme: .default))
) {
    Text("Hello, World!")
        .foregroundStyle(.themeColor(for: .primaryLabel))
}
