<!--
{
  "documentType" : "tutorial",
  "framework" : "SwiftUITheming",
  "identifier" : "/tutorials/SwiftUITheming/02-01-ChangeThemesAtRuntime",
  "metadataVersion" : "0.1.0",
  "title" : "Change themes at runtime"
}
-->

# Change themes at runtime

Learn how to dynamically change themes at runtime.

## Section 1: Create a view to change the theme

Before enabling theme changes at runtime, you need a mechanism to trigger the change. This tutorial assumes the change is user-driven through a UI. However, themes can also be changed programmatically without a UI.

### Step 1

Create a file named `ThemeChangerView.swift`.

### Step 2

Access the `ThemeManager` instance from the environment.

### Step 3

In the view’s body, create a binding to the `ThemeManager` instance.

This is required because `ThemeManager` is marked as an `@Observable` type.

### Step 4

Next, add the basic structure of the view. In this case, use a simple `Form` containing a single entry for a picker, allowing the user to select a theme.

### Step 5

Implement the picker as you would any other picker in SwiftUI. Since `Theme` instances conform to `Hashable`, they can be directly used in the `tag` modifier. Additionally, use `@Bindable` to link the picker’s selection directly to the `selectedTheme` property of the `ThemeManager` instance.
            
            >     Note: For this implementation, ensure you have multiple themes defined in your app and their types are accessible to the module where your theme changer view is located.

*ThemeChangerView.swift*

```
import SwiftUI
import Theming

struct ThemeChangerView: View {
    // MARK: - Environment Properties
    @Environment(ThemeManager.self) private var themeManager

    var body: some View {
        @Bindable var themeManager = themeManager

        Form {
            Section("Display Settings") {
                Label {
                    Picker("Theme", selection: $themeManager.selectedTheme) {
                        Text("Default").tag(Theme.default)
                        Text("Custom").tag(Theme.custom)
                } icon: {
                    Image(systemName: "paintpalette")
                }
            }
        }
        .navigationTitle("Settings")
        #if os(iOS) || os(visionOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}
```

### Step 6

This implementation provides users with an interface to change themes at runtime. Feel free to enhance it further and create a more visually appealing theme picker using the techniques outlined here.

![](videos/dev.alexanderweiss.swiftui_theming/02-01-01-video-0001-swiftui-theming-demo.mp4)