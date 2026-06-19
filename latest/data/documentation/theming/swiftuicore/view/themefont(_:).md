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
  "identifier" : "/documentation/Theming/SwiftUICore/View/themeFont(_:)",
  "metadataVersion" : "0.1.0",
  "role" : "Instance Method",
  "symbol" : {
    "kind" : "Instance Method",
    "modules" : [
      "Theming",
      "SwiftUICore"
    ],
    "preciseIdentifier" : "s:7SwiftUI4ViewP7ThemingE9themeFontyQrAA0F0V9TextStyleOF"
  },
  "title" : "themeFont(_:)"
}
-->

# themeFont(_:)

Sets the default theme font for text in the view.

```
@MainActor func themeFont(_ style: Font.TextStyle) -> some View
```

## Parameters

`style`

The default font style to use in this view.

## Return Value

A view with the default theme font set to the value you supply.

## Discussion

The themed font must be present available on the currently selected [`Theme`](/documentation/Theming/Theme) instance in the environment.