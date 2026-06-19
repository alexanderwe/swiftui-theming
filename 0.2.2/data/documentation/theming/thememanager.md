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
  "identifier" : "/documentation/Theming/ThemeManager",
  "metadataVersion" : "0.1.0",
  "role" : "Class",
  "symbol" : {
    "kind" : "Class",
    "modules" : [
      "Theming"
    ],
    "preciseIdentifier" : "s:7Theming12ThemeManagerC"
  },
  "title" : "ThemeManager"
}
-->

# ThemeManager

Manages the currently available theme in the app.

```
@MainActor class ThemeManager
```

## Overview

Use [`withThemeManager(themeManager:)`](/documentation/Theming/SwiftUI/Scene/withThemeManager(themeManager:)) in order to set a [`ThemeManager`](/documentation/Theming/ThemeManager) instance to a [`Scene`](/documentation/Theming/SwiftUI/Scene).

```swift
@main
struct ThemingDemoApp: App {
   // MARK: - State Properties
   @State var myThemeManager: ThemeManager = ThemeManager(initialTheme: .default)

   // MARK: - Body
   var body: some Scene {
       WindowGroup {
           ContentView()
       }
       .withThemeManager(themeManager: myThemeManager)
   }
}
```