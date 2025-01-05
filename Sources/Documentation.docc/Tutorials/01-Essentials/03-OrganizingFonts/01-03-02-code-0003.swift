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
            let fonts: Theme.FontMap = [
                .largeTitle: Font.custom("CustomFont-Regular", size: 34, relativeTo: .largeTitle),
                .title: Font.custom("CustomFont-Regular", size: 28, relativeTo: .title),
                .title2: Font.custom("CustomFont-Regular", size: 22, relativeTo: .title2),
                .title3: Font.custom("CustomFont-Regular", size: 20, relativeTo: .title3),
                .headline: Font.custom("CustomFont-Regular", size: 17, relativeTo: .headline),
                .body: Font.custom("CustomFont-Regular", size: 17, relativeTo: .body),
                .callout: Font.custom("CustomFont-Regular", size: 16, relativeTo: .callout),
                .subheadline: Font.custom("CustomFont-Regular", size: 15, relativeTo: .subheadline),
                .footnote: Font.custom("CustomFont-Regular", size: 13, relativeTo: .footnote),
                .caption: Font.custom("CustomFont-Regular", size: 12, relativeTo: .caption),
                .caption2: Font.custom("CustomFont-Regular", size: 11, relativeTo: .caption2),
            ]
    }
}
