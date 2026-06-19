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
  "identifier" : "/documentation/Theming/ThemeColor",
  "metadataVersion" : "0.1.0",
  "role" : "Structure",
  "symbol" : {
    "kind" : "Structure",
    "modules" : [
      "Theming"
    ],
    "preciseIdentifier" : "s:7Theming10ThemeColorV"
  },
  "title" : "ThemeColor"
}
-->

# ThemeColor

A color representing all possible variations where this color is used.

```
struct ThemeColor
```

## Overview

A theme color consists of various different colors combining these possible traits:

- light/dark mode
- base/elevated interface level
- standard/high contrast

Not all traits are available on all platforms. iOS and visionOS platforms offer all three traits. watchOS and visionOS
platforms only offer dark mode and standard/high contrast colors.