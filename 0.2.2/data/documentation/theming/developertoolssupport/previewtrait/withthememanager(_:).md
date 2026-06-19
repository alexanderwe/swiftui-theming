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
  "identifier" : "/documentation/Theming/DeveloperToolsSupport/PreviewTrait/withThemeManager(_:)",
  "metadataVersion" : "0.1.0",
  "role" : "Type Method",
  "symbol" : {
    "kind" : "Type Method",
    "modules" : [
      "Theming",
      "DeveloperToolsSupport"
    ],
    "preciseIdentifier" : "s:21DeveloperToolsSupport12PreviewTraitV7ThemingAA0D0V10ViewTraitsORszlE16withThemeManageryACyAHGAD0jK0CFZ"
  },
  "title" : "withThemeManager(_:)"
}
-->

# withThemeManager(_:)

Apply a theme manager to the preview.

```
@MainActor static func withThemeManager(_ themeManager: ThemeManager) -> PreviewTrait<T>
```

## Parameters

`themeManager`

ThemeManager instance to use.

## Discussion

Use this preview trait to use a dedicated [`ThemeManager`](/documentation/Theming/ThemeManager) in your previews.

```swift
#Preview(
    traits: .withTheme(.createDefaultTheme())
) {
    Text("Hello, world!")
            .foregroundStyle(.themeColor(for: .primaryLabel))
}
```