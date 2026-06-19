<!--
{
  "availability" : [
    "iOS: 18.0.0 -",
    "iPadOS: 18.0.0 -",
    "macCatalyst: 18.0.0 -",
    "macOS: 15.0.0 -",
    "tvOS: 18.0.0 -",
    "visionOS: 2.0.0 -",
    "watchOS: 11.0.0 -"
  ],
  "documentType" : "symbol",
  "framework" : "SwiftUITheming",
  "identifier" : "/documentation/Theming/Theme",
  "metadataVersion" : "0.1.0",
  "role" : "Structure",
  "symbol" : {
    "kind" : "Structure",
    "modules" : [
      "Theming"
    ],
    "preciseIdentifier" : "s:7Theming5ThemeV"
  },
  "title" : "Theme"
}
-->

# Theme

Base type for the theming system describing a single theme.

```
struct Theme
```

## Overview

You can create your own themes by creating new instances of this type. When creating your own theme, pay attention to the
different platforms that you support. Especially since not all color variations are availble on all platforms:

```swift
// MARK: - Available Themes
extension Theme {
    static let `default`: Theme = .createDefaultTheme()
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
}
```

> Remark: While a theme can be used to set custom fonts within the app, the general recommendation is to stick to the Apple
> default provided fonts. They offer predictable, tested and best UI looking results. Per default a newly created ``doc://dev.alexanderweiss.swiftui_theming/documentation/Theming/Theme``
> instance will use Apple’s default font via ``Theming/Theme/FontMap/appleDefault``