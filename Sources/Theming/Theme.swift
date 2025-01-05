//
//  Theme.swift
//  Theming
//
//  Created by Weiß, Alexander on 28.12.24.
//

import SwiftUI

/// Base type for the theming system describing a single theme.
///
/// You can create your own themes by creating new instances of this type. When creating your own theme, pay attention to the
/// different platforms that you support. Especially since not all color variations are availble on all platforms:
///
/// ```swift
/// extension Theme {
///     static let `default`: Theme = .createDefaultTheme()
/// }
///
/// MARK: - Theme creation
/// extension Theme {
///     private static func createDefaultTheme() -> Theme {
///         let colors: Theme.ColorMap
///
///         #if os(iOS) || os(visionOS)
///         colors = [
///             .primaryLabel: ThemeColor(lightColor: .primary, darkColor: .primary),
///             .primaryGroupedBackground: ThemeColor(lightColor: .gray, darkColor: .black),
///         ]
///         #elseif os(watchOS)
///         colors = [
///             .primaryLabel: ThemeColor(darkColor: .white, darkHighContrast: .white),
///             .primaryGroupedBackground: ThemeColor(darkColor: .black, darkHighContrast: .black),
///         ]
///         #elseif os(macOS) || os(tvOS)
///         colors = [
///             .primaryLabel: ThemeColor(lightColor: .primary, darkColor: .primary),
///             .primaryGroupedBackground: ThemeColor(lightColor: .gray, darkColor: .black),
///         ]
///         #endif
///         return Theme(name: "Default", colors: colors)
///     }
/// }
/// ```
/// - Remark: While a theme can be used to set custom fonts within the app, the general recommendation is to stick to the Apple
/// default provided fonts. They offer predictable, tested and best UI looking results. Per default a newly created ``Theme``
/// instance will use Apple's default font via ``/Theming/Theme/FontMap/appleDefault-property``
public struct Theme: Sendable, Identifiable {
    // MARK: - Public Properties
    /// ID to uniquely identify this theme.
    ///
    /// The value is derived from ``name``
    public var id: String { name }

    /// The name of the theme.
    public let name: String

    // MARK: - Private Properties

    /// Color mappings in this theme.
    private let colors: ColorMap

    /// Font mappings in this theme.
    private let fonts: FontMap

    // MARK: - Initilizer

    /// Create a new theme.
    ///
    /// - Parameters:
    ///   - name: The name of the themes.
    ///   - colors: The colors of the theme.
    ///   - fonts: The fonts of the theme. If no fonts are specified the default Apple font styles will be used.
    public init(
        name: String,
        colors: Theme.ColorMap,
        fonts: Theme.FontMap = .appleDefault
    ) {
        self.name = name
        self.colors = colors
        self.fonts = fonts
    }

    // MARK: - Methods
    func color(for style: ThemeColorStyle, with traits: ThemeTraits) -> Color? {
        colors[style]?.resolve(with: traits)
    }

    func font(for style: Font.TextStyle) -> Font? {
        fonts[style]
    }
}

// MARK: - Typealias
extension Theme {
    /// A mapping from ``ThemeColorStyle`` to ``ThemeColor``
    public typealias ColorMap = [ThemeColorStyle: ThemeColor]

    /// A mapping from ``/SwiftUICore/Font.TextStyle`` to ``/SwiftUICore/Font``
    public typealias FontMap = [Font.TextStyle: Font]
}

// MARK: - Hashable
extension Theme: Hashable {
    public static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
