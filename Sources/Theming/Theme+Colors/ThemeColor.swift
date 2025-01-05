//
//  ThemeColor.swift
//  Theming
//
//  Created by Weiß, Alexander on 28.12.24.
//

import SwiftUI

// MARK: - ThemeColor

/// A color representing all possible variations where this color is used.
///
/// A theme color consists of various different colors combining these possible traits:
/// * light/dark mode
/// * base/elevated interface level
/// * standard/high contrast
///
/// Not all traits are available on all platforms. iOS and visionOS platforms offer all three traits. watchOS and visionOS
/// platforms only offer dark mode and standard/high contrast colors.
public struct ThemeColor: Sendable {
    // MARK: - Public Properties
    #if os(visionOS) || os(iOS) || os(macOS) || os(tvOS)
    /// The color used in light mode.
    public let lightColor: Color

    /// The color used in light mode with high contrast enabled.
    ///
    /// If nil, ``lightColor`` is used.
    public let lightHighContrast: Color?
    #endif

    #if os(visionOS) || os(iOS)
    /// The color used in light mode in elevated interface levels.
    ///
    /// If nil, ``lightColor`` is used.
    public let lightElevated: Color?

    /// The color used in light mode with high contrast enabled and elevated interface levels.
    ///
    /// If nil, ``lightColor`` is used.
    public let lightElevatedHighContrast: Color?
    #endif

    /// The color used in dark mode.
    public let darkColor: Color

    /// The color used in dark mode with high contrast enabled.
    ///
    /// If nil, ``darkColor`` is used.
    public let darkHighContrast: Color?

    #if os(visionOS) || os(iOS)
    /// The color used in dark mode in elevated interface levels.
    ///
    /// If nil, ``darkColor`` is used.
    public let darkElevated: Color?

    /// The color used in dark mode with high contrast enabled and elevated interface levels.
    ///
    /// If nil, ``darkColor`` is used.
    public let darkElevatedHighContrast: Color?
    #endif

    #if os(visionOS) || os(iOS)
    /// Create a new theme color instance.
    ///
    /// - Parameters:
    ///   - lightColor: The color used in light mode.
    ///   - lightHighContrast: The color used in light mode with high contrast enabled.
    ///   - lightElevated: The color used in light mode in elevated interface levels.
    ///   - lightElevatedHighContrast: The color used in light mode with high contrast enabled and elevated interface levels
    ///   - darkColor: The color used in dark mode.
    ///   - darkHighContrast: The color used in dark mode with high contrast enabled.
    ///   - darkElevated: The color used in light mode in elevated interface levels.
    ///   - darkElevatedHighContrast: The color used in dark mode with high contrast enabled and elevated interface levels.
    public init(
        lightColor: Color,
        lightHighContrast: Color? = nil,
        lightElevated: Color? = nil,
        lightElevatedHighContrast: Color? = nil,
        darkColor: Color,
        darkHighContrast: Color? = nil,
        darkElevated: Color? = nil,
        darkElevatedHighContrast: Color? = nil
    ) {
        self.lightColor = lightColor
        self.lightHighContrast = lightHighContrast
        self.lightElevated = lightElevated
        self.lightElevatedHighContrast = lightElevatedHighContrast
        self.darkColor = darkColor
        self.darkHighContrast = darkHighContrast
        self.darkElevated = darkElevated
        self.darkElevatedHighContrast = darkElevatedHighContrast
    }
    #endif

    #if os(watchOS)
    /// Create a new theme color instance.
    ///
    /// - Parameters:
    ///   - darkColor:  The color used in dark mode.
    ///   - darkHighContrast: The color used in dark mode with high contrast enabled.
    public init(darkColor: Color, darkHighContrast: Color) {
        self.darkColor = darkColor
        self.darkHighContrast = darkHighContrast
    }
    #endif

    #if os(macOS) || os(tvOS)
    /// Create a new theme color instance.
    ///
    /// - Parameters:
    ///   - lightColor: The color used in light mode.
    ///   - lightHighContrast: The color used in light mode with high contrast enabled.
    ///   - darkColor: The color used in dark mode.
    ///   - darkHighContrast: The color used in dark mode with high contrast enabled.
    public init(
        lightColor: Color,
        lightHighContrast: Color? = nil,
        darkColor: Color,
        darkHighContrast: Color? = nil
    ) {
        self.lightColor = lightColor
        self.lightHighContrast = lightHighContrast
        self.darkColor = darkColor
        self.darkHighContrast = darkHighContrast
    }
    #endif

    // MARK: - Color resolution
    #if os(visionOS) || os(iOS)

    /// Resolves a color based on the given traits.
    ///
    /// - Parameters:
    ///   - traits: The traits used to resolve the color.
    /// - Returns: A color matching the given traits.
    func resolve(with traits: ThemeTraits) -> Color {
        return switch (traits.colorScheme, traits.colorSchemeContrast, traits.interfaceLevel) {
        case (.light, .standard, .base):
            lightColor

        case (.light, .standard, .elevated):
            lightElevated ?? lightColor

        case (.light, .increased, .base):
            lightHighContrast ?? lightColor

        case (.light, .increased, .elevated):
            lightElevatedHighContrast ?? lightColor

        case (.dark, .standard, .base):
            darkColor

        case (.dark, .standard, .elevated):
            darkElevated ?? darkColor

        case (.dark, .increased, .base):
            darkHighContrast ?? darkColor

        case (.dark, .increased, .elevated):
            darkElevatedHighContrast ?? darkColor

        default:
            fatalError()
        }
    }
    #endif

    #if os(watchOS)
    /// Resolves a color based on the given traits.
    ///
    /// - Parameters:
    ///   - traits: The traits used to resolve the color.
    /// - Returns: A color matching the given traits.
    func resolve(with traits: ThemeTraits) -> Color {
        return switch (traits.colorScheme, traits.colorSchemeContrast) {
        case (.dark, .standard):
            darkColor
        case (.dark, .increased):
            darkHighContrast ?? darkColor
        default:
            fatalError()
        }
    }
    #endif

    #if os(macOS) || os(tvOS)
    /// Resolves a color based on the given traits.
    ///
    /// - Parameters:
    ///   - traits: The traits used to resolve the color.
    /// - Returns: A color matching the given traits.
    func resolve(with traits: ThemeTraits) -> Color {
        return switch (traits.colorScheme, traits.colorSchemeContrast) {
        case (.light, .standard):
            lightColor

        case (.light, .increased):
            lightHighContrast ?? lightColor

        case (.dark, .standard):
            darkColor

        case (.dark, .increased):
            darkHighContrast ?? darkColor

        default:
            fatalError()
        }
    }
    #endif
}

// MARK: - ThemeColorShapeStyle

/// A shape style representing a theme color.
///
/// It is used to resolve a theme color when ``themeColor(for:)`` is used.
public struct ThemeColorShapeStyle: ShapeStyle {
    // MARK: - Private Properties
    private let style: ThemeColorStyle

    // MARK: - Initialisers
    public init(style: ThemeColorStyle) {
        self.style = style
    }

    // MARK: - Resolve
    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        guard let theme = environment.theme else {
            fatalError(
                "No theme was attached to the environment but a custom theme color was requested.\nAt the moment it is not supported to resolve a theming color without a theme set. This is a programmer error."
            )
        }

        guard let color = theme.color(for: style, with: environment.themeTraits) else {
            fatalError(
                "No color for style '\(style.name)' found in theme named '\(theme.name)'. Please make sure that all themes cover all available color styles. This is a programmer error"
            )
        }
        return color
    }
}

extension ShapeStyle where Self == ThemeColorShapeStyle {
    /// A context-dependent theme color shape suitable for use in UI elements.
    ///
    /// - Parameters:
    ///   - style: The color style to be used.
    /// - Returns: A shape base on the current environment and color style.
    public static func themeColor(for style: ThemeColorStyle) -> ThemeColorShapeStyle {
        ThemeColorShapeStyle(style: style)
    }
}

extension Color {
    /// A context-dependent theme color shape suitable for use in UI elements.
    ///
    /// - Parameters:
    ///   - style: The color style to be used.
    /// - Returns: A shape base on the current environment and color style.
    public static func themeColor(for style: ThemeColorStyle) -> ThemeColorShapeStyle {
        ThemeColorShapeStyle(style: style)
    }
}
