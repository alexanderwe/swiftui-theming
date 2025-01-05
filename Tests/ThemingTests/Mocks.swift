//
//  Mocks.swift
//  ThemingTests
//
//  Created by Weiß, Alexander on 03.01.25.
//

import Theming

// MARK: - Mocked Theme Color Styles
extension ThemeColorStyle {
    static let primaryGroupedBackground: Self = Self(name: "primaryBackground")
}

// MARK: - Mocked Themes
extension Theme {
    static let `default`: Theme = .createDefaultTheme()
    static let custom: Theme = .createCustomTheme()
}

// MARK: - Theme creation
extension Theme {
    private static func createDefaultTheme() -> Theme {
        let colors: Theme.ColorMap

        #if os(iOS) || os(visionOS)
        colors = [
            .primaryGroupedBackground: ThemeColor(lightColor: .gray, darkColor: .black),
        ]
        #elseif os(watchOS)
        colors = [
            .primaryGroupedBackground: ThemeColor(darkColor: .black, darkHighContrast: .black),
        ]
        #elseif os(macOS) || os(tvOS)
        colors = [
            .primaryGroupedBackground: ThemeColor(lightColor: .gray, darkColor: .black),
        ]
        #endif

        return Theme(name: "Default", colors: colors)
    }

    private static func createCustomTheme() -> Theme {
        let colors: Theme.ColorMap

        #if os(iOS) || os(visionOS)
        colors = [
            .primaryGroupedBackground: ThemeColor(lightColor: .red, darkColor: .blue),
        ]
        #elseif os(watchOS)
        colors = [
            .primaryGroupedBackground: ThemeColor(darkColor: .blue, darkHighContrast: .purple),
        ]
        #elseif os(macOS) || os(tvOS)
        colors = [
            .primaryGroupedBackground: ThemeColor(lightColor: .red, darkColor: .blue),
        ]
        #endif
        return Theme(name: "Custom", colors: colors)
    }
}
