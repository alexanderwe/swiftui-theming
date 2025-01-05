//
//  ThemeColorStyle.swift
//  Theming
//
//  Created by Weiß, Alexander on 28.12.24.
//

import Foundation

/// Represents a color style in a theme.
///
/// Use this type to create new color styles for a theme of the app.
/// The recommended way to create a new style is to extend
/// ``ThemeColorStyle`` and create static properties for each of the possible color styles.
///
/// ```swift
/// extension ThemeColorStyle {
///     static let primaryBackground: Self = Self(name: "primaryBackground")
/// }
/// ```
public struct ThemeColorStyle: Identifiable, Sendable {
    /// ID to uniquely identify this style.
    ///
    /// The value is derived from ``name``
    public var id: String { name }

    /// The name of the color style
    public let name: String

    // MARK: - Initializer
    public init(name: String) {
        self.name = name
    }
}

// MARK: - Hashable
extension ThemeColorStyle: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
