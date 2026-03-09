//
//  ThemeFontTests.swift
//  ThemingTests
//
//  Created by Weiß, Alexander on 03.01.25.
//

import SwiftUI
import Testing
@testable import Theming

@MainActor
struct ThemeFontTests {
    @Test(
        "Default Font is correctly resolved",
        arguments: [
            (Font.TextStyle.largeTitle, Font.largeTitle),
            (Font.TextStyle.title, Font.title),
            (Font.TextStyle.title2, Font.title),
            (Font.TextStyle.title3, Font.title3),
            (Font.TextStyle.headline, Font.headline),
            (Font.TextStyle.body, Font.body),
            (Font.TextStyle.callout, Font.callout),
            (Font.TextStyle.subheadline, Font.subheadline),
            (Font.TextStyle.footnote, Font.footnote),
            (Font.TextStyle.caption, Font.caption),
            (Font.TextStyle.caption2, Font.caption2),
        ]
    )
    func defaultThemeFontResolution(textStyle: Font.TextStyle, expectedFont: Font) {
        // Given
        let theme: Theme = .default

        // When
        let resolvedFont = theme.font(for: textStyle)

        // Then
        #expect(resolvedFont == expectedFont)
    }
}
