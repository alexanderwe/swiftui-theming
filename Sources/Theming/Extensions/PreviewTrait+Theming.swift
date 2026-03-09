//
//  PreviewTrait+Theming.swift
//  swiftui-theming
//
//  Created by Weiß, Alexander on 07.03.26.
//

import SwiftUI

// MARK: - PreviewModifier

/// A preview modifier to preview views with themes.
struct ThemePreviewTrait: PreviewModifier {
    // MARK: - Private Properties
    @State var themeManager: ThemeManager

    // MARK: - Body
    func body(content: Content, context _: Void) -> some View {
        content
            .environment(themeManager)
            .environment(\.theme, themeManager.selectedTheme)
    }
}

// MARK: - Public Extensions
extension PreviewTrait where T == Preview.ViewTraits {
    /// Apply a theme manager to the preview.
    ///
    /// Use this preview trait to use a dedicated ``/Theming/ThemeManager`` in your previews.
    ///
    /// ```swift
    /// #Preview(
    ///     traits: .withTheme(.createDefaultTheme())
    /// ) {
    ///     Text("Hello, world!")
    ///             .foregroundStyle(.themeColor(for: .primaryLabel))
    /// }
    /// ```
    /// - Parameters:
    ///   - themeManager: ThemeManager instance to use.
    public static func withThemeManager(_ themeManager: ThemeManager) -> Self {
        .modifier(ThemePreviewTrait(themeManager: themeManager))
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    /// Apply a theme to the preview.
    ///
    /// Use this preview trait to use a dedicated ``/Theming/Theme`` in your previews.
    ///
    /// ```swift
    /// #Preview(
    ///     traits: .withTheme(.createDefaultTheme())
    /// ) {
    ///     Text("Hello, world!")
    ///             .foregroundStyle(.themeColor(for: .primaryLabel))
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - theme: Theme to use.
    public static func withTheme(_ theme: Theme) -> Self {
        .modifier(ThemePreviewTrait(themeManager: ThemeManager(initialTheme: theme)))
    }
}
