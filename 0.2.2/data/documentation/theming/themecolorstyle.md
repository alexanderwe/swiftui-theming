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
  "identifier" : "/documentation/Theming/ThemeColorStyle",
  "metadataVersion" : "0.1.0",
  "role" : "Structure",
  "symbol" : {
    "kind" : "Structure",
    "modules" : [
      "Theming"
    ],
    "preciseIdentifier" : "s:7Theming15ThemeColorStyleV"
  },
  "title" : "ThemeColorStyle"
}
-->

# ThemeColorStyle

Represents a color style in a theme.

```
struct ThemeColorStyle
```

## Overview

Use this type to create new color styles for a theme of the app.
The recommended way to create a new style is to extend
[`ThemeColorStyle`](/documentation/Theming/ThemeColorStyle) and create static properties for each of the possible color styles.

```swift
extension ThemeColorStyle {
    static let primaryBackground: Self = Self(name: "primaryBackground")
}
```