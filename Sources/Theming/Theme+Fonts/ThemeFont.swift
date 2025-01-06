//
//  ThemeFont.swift
//  Theming
//
//  Created by Weiß, Alexander on 03.01.25.
//

import SwiftUI

extension View {
    /// Sets the default theme font for text in the view.
    ///
    /// The themed font must be present available on the currently selected ``/Theming/Theme`` instance in the environment.
    ///
    /// - Parameters:
    ///   - style: The default font style to use in this view.
    /// - Returns: A view with the default theme font set to the value you supply.
    public func themeFont(_ style: Font.TextStyle) -> some View {
        self.modifier(ThemeFontModifier(style))
    }
}

// MARK: - Theme Font Modifier
/// A view modifier used to resolve the correct font
///
/// Use ``View/themeFont`(_:)`` in order to set the theme font of a view.
struct ThemeFontModifier: ViewModifier {
    // MARK: - Environment Properties
    @Environment(\.theme) private var theme: Theme?

    // MARK: - Private Properties
    private let style: Font.TextStyle

    // MARK: - Initializer
    init(_ style: Font.TextStyle) {
        self.style = style
    }

    // MARK: - Body
    func body(content: Content) -> some View {
        resolveFont { font in content.font(font) }
    }

    // MARK: - Font Resolution
    @ViewBuilder
    func resolveFont(@ViewBuilder _ content: (Font) -> some View) -> some View {
        if let theme {
            if let font = theme.font(for: style) {
                content(font)
            } else {
                fatalError(
                    "No font for style '\(style)' found in theme named '\(theme.name)'. Please make sure that all themes cover all available text styles. This is a programmer error"
                )
            }
        } else {
            fatalError(
                "No theme was attached to the environment but a custom theme color was requested.\nAt the moment it is not supported to resolve a theming color without a theme set. This is a programmer error."
            )
        }
    }
}

// MARK: - Default Apple Font mapping
extension Theme.FontMap {
    /// The default platform font mapping.
    public static let appleDefault: Self = [
        .largeTitle: Font.largeTitle,
        .title: Font.title,
        .title2: Font.title,
        .title3: Font.title3,
        .headline: Font.headline,
        .body: Font.body,
        .callout: Font.callout,
        .subheadline: Font.subheadline,
        .footnote: Font.footnote,
        .caption: Font.caption,
        .caption2: Font.caption2,
    ]
}
