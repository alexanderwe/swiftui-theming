//
//  ThemeManagerTests.swift
//  ThemingTests
//
//  Created by Weiß, Alexander on 03.01.25.
//

import Testing
@testable import Theming

@MainActor
@Suite("Theme Manager Tests")
struct ThemeManagerTests {
    @Test("Selected Theme is correctly set")
    func testThemeSelection() async throws {
        // Given
        let themeManager = ThemeManager(initialTheme: .default)

        // When
        themeManager.selectedTheme = .custom

        // Then
        #expect(themeManager.selectedTheme.id == Theme.custom.name)
    }
}
