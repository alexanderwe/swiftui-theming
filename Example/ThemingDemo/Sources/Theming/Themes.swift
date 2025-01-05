//
//  Themes.swift
//  ThemingDemo
//
//  Created by Weiß, Alexander on 28.12.24.
//

import SwiftUI
import Theming

// MARK: - Available Themes
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
            .primaryLabel: ThemeColor(lightColor: .primary, darkColor: .primary),
            .primaryGroupedBackground: ThemeColor(lightColor: .gray, darkColor: .black),
        ]
        #elseif os(watchOS)
        colors = [
            .primaryLabel: ThemeColor(darkColor: .white, darkHighContrast: .white),
            .primaryGroupedBackground: ThemeColor(darkColor: .black, darkHighContrast: .black),
        ]
        #elseif os(macOS) || os(tvOS)
        colors = [
            .primaryLabel: ThemeColor(lightColor: .primary, darkColor: .primary),
            .primaryGroupedBackground: ThemeColor(lightColor: .gray, darkColor: .black),
        ]
        #endif
        return Theme(name: "Default", colors: colors)
    }

    private static func createCustomTheme() -> Theme {
        let colors: Theme.ColorMap

        #if os(iOS) || os(visionOS)
        colors = [
            .primaryLabel: ThemeColor(lightColor: .blue, darkColor: .red),
            .primaryGroupedBackground: ThemeColor(lightColor: .red, darkColor: .blue),
        ]
        #elseif os(watchOS)
        colors = [
            .primaryLabel: ThemeColor(darkColor: .red, darkHighContrast: .red),
            .primaryGroupedBackground: ThemeColor(darkColor: .blue, darkHighContrast: .purple),
        ]
        #elseif os(macOS) || os(tvOS)
        colors = [
            .primaryLabel: ThemeColor(lightColor: .blue, darkColor: .red),
            .primaryGroupedBackground: ThemeColor(lightColor: .red, darkColor: .blue),
        ]
        #endif

        let fonts: Theme.FontMap = [
            .largeTitle: Font.custom("FuzzyBubbles-Regular", size: 34, relativeTo: .largeTitle),
            .body: Font.custom("FuzzyBubbles-Regular", size: 17, relativeTo: .body),
        ]

        return Theme(name: "Custom", colors: colors, fonts: fonts)
    }
}
