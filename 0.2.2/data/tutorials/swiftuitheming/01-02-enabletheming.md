<!--
{
  "documentType" : "tutorial",
  "framework" : "SwiftUITheming",
  "identifier" : "/tutorials/SwiftUITheming/01-02-EnableTheming",
  "metadataVersion" : "0.1.0",
  "title" : "Enable Theming"
}
-->

# Enable Theming

Learn how to enable theming in your SwiftUI application.

## Section 1: Add the Theme Manager

Inject the theme manager into your app’s scenes to enable consistent theming across all scenes.

### Step 1

Declare a `@State` property in your app definition to hold the `ThemeManager` instance. This instance is responsible for managing the currently selected theme.

### Step 2

Use the `.withThemeManager(themeManager:)` method to make the `ThemeManager` instance accessible across all scenes in your application where theming is required.

*MyApp.swift*

```
import SwiftUI
import Theming

@main
struct MyApp: App {
    @State var themeManager: ThemeManager = ThemeManager(initialTheme: .default)

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .withThemeManager(themeManager: themeManager)

        #if os(macOS)
        Settings {
            SettingsScreen()
                .scenePadding()
                .frame(maxWidth: 350, minHeight: 100)
        }
        .withThemeManager(themeManager: themeManager)
        #endif
    }
}
```

### Step 3

That’s it! Theming is now enabled in your application. You can use it to access theme colors and fonts in your views.