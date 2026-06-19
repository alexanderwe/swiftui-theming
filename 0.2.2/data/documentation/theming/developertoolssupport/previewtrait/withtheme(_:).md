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
  "identifier" : "/documentation/Theming/DeveloperToolsSupport/PreviewTrait/withTheme(_:)",
  "metadataVersion" : "0.1.0",
  "role" : "Type Method",
  "symbol" : {
    "kind" : "Type Method",
    "modules" : [
      "Theming",
      "DeveloperToolsSupport"
    ],
    "preciseIdentifier" : "s:21DeveloperToolsSupport12PreviewTraitV7ThemingAA0D0V10ViewTraitsORszlE9withThemeyACyAHGAD0J0VFZ"
  },
  "title" : "withTheme(_:)"
}
-->

# withTheme(_:)

Apply a theme to the preview.

```
@MainActor static func withTheme(_ theme: Theme) -> PreviewTrait<T>
```

## Parameters

`theme`

Theme to use.

## Discussion

Use this preview trait to use a dedicated [`Theme`](/documentation/Theming/Theme) in your previews.

```swift
#Preview(
    traits: .withTheme(.createDefaultTheme())
) {
    Text("Hello, world!")
            .foregroundStyle(.themeColor(for: .primaryLabel))
}
```