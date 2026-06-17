<!--
{
  "availability" : [
    "iOS: 18.0 -",
    "iPadOS: 18.0 -",
    "macCatalyst: 18.0 -",
    "macOS: 15.0 -",
    "tvOS: 18.0 -",
    "visionOS: 2.0 -",
    "watchOS: 11.0 -"
  ],
  "documentType" : "symbol",
  "framework" : "SwiftUITheming",
  "identifier" : "/documentation/Theming/SwiftUI/Scene/withThemeManager(themeManager:)",
  "metadataVersion" : "0.1.0",
  "role" : "Instance Method",
  "symbol" : {
    "kind" : "Instance Method",
    "modules" : [
      "Theming",
      "SwiftUI"
    ],
    "preciseIdentifier" : "s:7SwiftUI5SceneP7ThemingE16withThemeManager05themeG0QrAD0fG0C_tF"
  },
  "title" : "withThemeManager(themeManager:)"
}
-->

# withThemeManager(themeManager:)

Decorate a scene with a theme manager.

```
@MainActor func withThemeManager(themeManager: ThemeManager) -> some Scene
```

## Parameters

`themeManager`

Theme manager to be used for theming this scene.

## Return Value

A new themed scene.

## Discussion

Use this method to enable a scene to be themed. It will enable children to access the [`ThemeManager`](/documentation/Theming/ThemeManager) and the currently
selected [`Theme`](/documentation/Theming/Theme) instance in the Environment:

```swift
import Theming

struct MyView: View {
   @Environment(\.theme) private var selectedTheme: Theme
   @Environment(ThemeManager.self) private var themeManager: ThemeManager
}
```