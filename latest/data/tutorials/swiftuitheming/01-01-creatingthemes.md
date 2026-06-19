<!--
{
  "documentType" : "tutorial",
  "framework" : "SwiftUITheming",
  "identifier" : "/tutorials/SwiftUITheming/01-01-CreatingThemes",
  "metadataVersion" : "0.1.0",
  "title" : "Create your first theme"
}
-->

# Create your first theme

Learn how to create and organize themes effectively in your application.

## Section 1: Create a theme

Take the initial steps to make your app themeable.

### Step 1

Create a new SwiftUI View file named `Themes.swift`. This file will serve as the central location for all the themes used in your app.

### Step 2

Each theme requires a name, a color mapping table, and optionally, a font mapping table. While the font mapping table is optional, the name and color mapping table are mandatory.

### Step 3

To gain better control over theme creation, use dedicated methods for each theme. This approach is similar to implementing a factory method.

*Themes.swift*

```
import Theming

// MARK: - Available Themes
extension Theme {
    static let `default`: Theme = .createDefaultTheme()
}

// MARK: - Theme creation
extension Theme {
    private static func createDefaultTheme() -> Theme {}
}
```

### Step 4

With the foundational setup complete, proceed to create color mappings. Start by creating a new file named `ThemeColors.swift`. This file will define all the color styles your app supports, typically derived from your app’s design guidelines. Each color style is uniquely identified by a name.

*ThemesColors.swift*

```
import Theming

extension ThemeColorStyle {
    /// The color for a primary label.
    static let primaryLabel: Self = Self(name: "primaryLabel")

    /// The color for a secondary label.
    static let secondaryLabel: Self = Self(name: "secondaryLabel")

    /// The color for a tertiary label.
    static let tertiaryLabel: Self = Self(name: "tertiaryLabel")

    /// The color for a primary background.
    static let primaryBackground: Self = Self(name: "primaryBackground")

    /// The color for a primary background used in a grouped list.
    static let primaryGroupedBackground: Self = Self(name: "primaryGroupedBackground")
}
```

### Step 5

Next, configure the mapping table to link color styles to their corresponding colors.

### Step 6

If your app supports multiple platforms, you may need to create different mappings, as not all color variants are available across every platform. This also allows you to define distinct color sets tailored to each platform.

### Step 7

Finally, create a theme instance, give it a meaningful name, and assign the color mapping you have defined.

### Step 8

If you want to test your themes with SwiftUI previews, you can use the built-in preview traits.

*Themes.swift*

```
import Theming

// MARK: - Available Themes
extension Theme {
    static let `default`: Theme = .createDefaultTheme()
}

// MARK: - Previews
#Preview("Preview a theme", traits: .withTheme(.default)) {
    Text("Hello, World!")
        .foregroundStyle(.themeColor(for: .primaryLabel))
}

#Preview(
    "Preview a theme manager",
    traits: .withThemeManager(ThemeManager(initialTheme: .default))
) {
    Text("Hello, World!")
        .foregroundStyle(.themeColor(for: .primaryLabel))
}
```