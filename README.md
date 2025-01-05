# SwiftUI Theming

[![Test](https://github.com/alexanderwe/swiftui-theming/actions/workflows/test.yml/badge.svg)](https://github.com/alexanderwe/swiftui-theming/actions/workflows/test.yml)

**SwiftUI Theming** is a library that enables seamless theming in SwiftUI across all Apple platforms, including iOS, macOS, tvOS, watchOS, and visionOS.

## Table of Contents

1. [Installation](#installation)
2. [Basic Usage](#basic-usage)
3. [Making Your App Themeable](#make-your-app-themeable)
4. [Documentation](#documentation)
5. [License](#license)

## Installation

You can integrate **swiftui-theming** into your Xcode project as a Swift Package:

### Xcode GUI

1. Go to **File > Add Package Dependency...**.
2. Enter the repository URL:
   `https://github.com/alexanderwe/swiftui-theming`
3. Choose the library and add it to your desired target.

### Using `Package.swift`

To add **swiftui-theming** via a `Package.swift` file, include the following dependency:

```swift
.package(url: "https://github.com/alexanderwe/swiftui-theming", from: "0.1.0")
```

Then, add it to your target dependencies:

```swift
.product(name: "Theming", package: "swiftui-theming")
```

---

## Basic Usage

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

With color styles defined, implement a method to create a theme:

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

## Make Your App Themeable

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

## Documentation

Comprehensive documentation is available [here](https://alexanderwe.github.io/swiftui-theming/documentation/overview).

## License

This library is released under the MIT License. See the [LICENSE](LICENSE) file for details.
