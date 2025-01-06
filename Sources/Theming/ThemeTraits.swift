//
//  ThemeTraits.swift
//  Theming
//
//  Created by Weiß, Alexander on 03.01.25.
//

import SwiftUI
#if os(visionOS) || os(iOS)
import UIKit
#endif

// MARK: - ThemeColorTraits
#if os(visionOS) || os(iOS)
/// Traits important for a theme.
public typealias ThemeTraits = (
    colorScheme: ColorScheme,
    colorSchemeContrast: ColorSchemeContrast,
    interfaceLevel: UIUserInterfaceLevel
)
#elseif os(watchOS) || os(tvOS) || os(macOS)
/// Traits important for a theme.
public typealias ThemeTraits = (colorScheme: ColorScheme, colorSchemeContrast: ColorSchemeContrast)
#endif

extension EnvironmentValues {
    /// The traits important for themes.
    var themeTraits: ThemeTraits {
        #if os(visionOS) || os(iOS)
        return (self.colorScheme, self.colorSchemeContrast, self.userInterfaceLevel)
        #elseif os(watchOS) || os(tvOS) || os(macOS)
        return (self.colorScheme, self.colorSchemeContrast)
        #endif
    }
}
