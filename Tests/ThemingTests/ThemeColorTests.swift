//
//  ThemeColorTests.swift
//  ThemingTests
//
//  Created by Weiß, Alexander on 03.01.25.
//

import SwiftUI
import Testing
@testable import Theming

@MainActor
@Suite("Theme Color Tests")
struct ThemeColorTests {
    #if os(iOS) || os(visionOS)
    @Test(
        "Color is correctly resolved",
        arguments: [
            (ThemeTraits(colorScheme: .light, colorSchemeContrast: .standard, interfaceLevel: .base), Color.black),
            (ThemeTraits(colorScheme: .light, colorSchemeContrast: .increased, interfaceLevel: .base), Color.blue),
            (ThemeTraits(colorScheme: .light, colorSchemeContrast: .standard, interfaceLevel: .elevated), Color.brown),
            (ThemeTraits(colorScheme: .light, colorSchemeContrast: .increased, interfaceLevel: .elevated), Color.clear),
            (ThemeTraits(colorScheme: .dark, colorSchemeContrast: .standard, interfaceLevel: .base), Color.cyan),
            (ThemeTraits(colorScheme: .dark, colorSchemeContrast: .increased, interfaceLevel: .base), Color.gray),
            (ThemeTraits(colorScheme: .dark, colorSchemeContrast: .standard, interfaceLevel: .elevated), Color.green),
            (ThemeTraits(colorScheme: .dark, colorSchemeContrast: .increased, interfaceLevel: .elevated), Color.indigo),
        ]
    )
    func testThemeColorResolution(traits: ThemeTraits, expectedColor: Color) async throws {
        // Given
        let themeColor: ThemeColor = ThemeColor(
            lightColor: .black,
            lightHighContrast: .blue,
            lightElevated: .brown,
            lightElevatedHighContrast: .clear,
            darkColor: .cyan,
            darkHighContrast: .gray,
            darkElevated: .green,
            darkElevatedHighContrast: .indigo
        )

        // When
        let resolvedColor = themeColor.resolve(with: traits)

        // Then
        #expect(resolvedColor == expectedColor)
    }
    #endif

    #if os(watchOS)
    @Test(
        "Color is correctly resolved",
        arguments: [
            (ThemeTraits(colorScheme: .dark, colorSchemeContrast: .standard), Color.cyan),
            (ThemeTraits(colorScheme: .dark, colorSchemeContrast: .increased), Color.gray),
        ]
    )
    func testThemeColorResolution(traits: ThemeTraits, expectedColor: Color) async throws {
        // Given
        let themeColor: ThemeColor = ThemeColor(
            darkColor: .cyan,
            darkHighContrast: .gray
        )

        // When
        let resolvedColor = themeColor.resolve(with: traits)

        // Then
        #expect(resolvedColor == expectedColor)
    }
    #endif

    #if os(macOS) || os(tvOS)
    @Test(
        "Color is correctly resolved",
        arguments: [
            (ThemeTraits(colorScheme: .light, colorSchemeContrast: .standard), Color.black),
            (ThemeTraits(colorScheme: .light, colorSchemeContrast: .increased), Color.blue),
            (ThemeTraits(colorScheme: .dark, colorSchemeContrast: .standard), Color.cyan),
            (ThemeTraits(colorScheme: .dark, colorSchemeContrast: .increased), Color.gray),
        ]
    )
    func testThemeColorResolution(traits: ThemeTraits, expectedColor: Color) async throws {
        // Given
        let themeColor: ThemeColor = ThemeColor(
            lightColor: .black,
            lightHighContrast: .blue,
            darkColor: .cyan,
            darkHighContrast: .gray
        )

        // When
        let resolvedColor = themeColor.resolve(with: traits)

        // Then
        #expect(resolvedColor == expectedColor)
    }
    #endif
}
