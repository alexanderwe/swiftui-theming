# Getting Started

Learn how to integrate SwiftUI Theming into your project.

## Adding swiftui-theming as a dependency

```swift
let package = Package(
  dependencies: [
    .package(
      url: "https://github.com/alexanderwe/swiftui-theming",
      from: "0.1.0"
    ),
  ],
  targets: [
    .target(
      name: "<target-name>",
      dependencies: [
        .product(
          name: "Theming",
          package: "swiftui-theming"
        )
      ]
    )
  ]
)
```

## Create your first theme

> Note: Be sure to checkout <doc:MeetSwiftUITheming> for an interactive tutorial.

### Step 1: Define Color Styles

Before creating a new theme, define the color styles available in your app:

```swift
import Theming

extension ThemeColorStyle {
    /// A style for primary labels
    static let primaryLabel: Self = Self(name: "primaryLabel")
    // Define additional styles as needed
}
```

### Step 2: Create a Theme

With color styles defined, implement a method to create a theme. Each theme requires to at least have a name and a color mapping. Depending on your needs you may need different mappings on different platforms since not all color ``/Theming/ThemeColor`` variants are available on all platforms.

```swift
import Theming
// MARK: - Available Themes
extension Theme {
    static let `default`: Theme = .createDefaultTheme()
}

// MARK: - Theme Creation
extension Theme {
    private static func createDefaultTheme() -> Theme {
        let colors: Theme.ColorMap = [
            .primaryLabel: ThemeColor(lightColor: .primary, darkColor: .primary)
        ]
        return Theme(name: "Default", colors: colors)
    }
}
```

## Make App themeable

To enable theming in your app, inject a `ThemeManager` instance into your app's scenes.

### Step 1: Initialize `ThemeManager`

Declare a `@State` property to hold the `ThemeManager` in your app definition:

```swift
import SwiftUI
import Theming

@main
struct MyApp: App {
    @State var myThemeManager: ThemeManager = ThemeManager(initialTheme: .default)

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .withThemeManager(themeManager: myThemeManager)
    }
}
```

### Step 2: Access Theme Colors in Views

Use the `.themeColor` method to apply theme colors in your SwiftUI views:

```swift
struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .foregroundStyle(.themeColor(for: .primaryLabel))
    }
}
```
