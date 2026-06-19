<!--
{
  "documentType" : "tutorial",
  "framework" : "SwiftUITheming",
  "identifier" : "/tutorials/SwiftUITheming/01-03-OrganizingFonts",
  "metadataVersion" : "0.1.0",
  "title" : "Organize Fonts"
}
-->

# Organize Fonts

Learn how to organize fonts for use in a theme.

## Section 1: Add Fonts to Your Application

By default, SwiftUI Theming uses Apple’s system fonts for all themes. This approach is recommended because Apple’s fonts are highly optimized, offer best-in-class features, and are fully compatible with SwiftUI’s font modifiers. However, certain situations or product requirements might necessitate the use of custom fonts. In this tutorial, you’ll learn how to enable custom fonts with SwiftUI Theming by registering them in the traditional way.
    
    >     Note: There is also a way to register fonts programmatically when distributed via a framework. This method is not covered in this tutorial yet.

### Step 1

To use custom fonts in your application, add the font files to your app’s resources. It’s best to keep resources organized and separate from source code files. If you haven’t done so already, create a folder named `Resources/Fonts` and place all your font files in it.

![A screenshot of Xcode showing the newly created 'Resources/Fonts' directory in the file tree. The right panel highlights the 'Copy Bundle Resources' step in the Xcode build phases, which includes the added custom fonts.](images/dev.alexanderweiss.swiftui_theming/01-03-01-image-0001.png)

### Step 2

Next, inform the application that it will use custom fonts. For `macOS` applications, set the `ATSApplicationFontsPath` key to `.` in your `Info.plist` file. For other platforms, declare all font files under the `UIAppFonts` key.
            
            >     Attention: Ensure that you include the file extensions for each font listed under the `UIAppFonts` key.

*Info.plist*

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <!--Used for all platforms except macOS-->
        <key>UIAppFonts</key>
        <array>
            <string>CustomFont-Bold.ttf</string>
            <string>CustomFont-Italic.ttf</string>
            <string>CustomFont-Regular.ttf</string>
        </array>
        <!--Used for macOS only-->
        <key>ATSApplicationFontsPath</key>
        <string>.</string>
    </dict>
</plist>
```

## Section 2: Accessing Your Custom Fonts in a Theme

After making the font files accessible to your app, the next step is to add them to a theme.

### Step 1

Start by using your existing code for creating themes.

### Step 2

To incorporate custom fonts into a theme, create a mapping table. This table maps the `Font.TextStyles` you want to use in your app to the custom fonts. You have flexibility in how you implement this mapping, as long as each text style maps to a `Font` instance.
            
            >     Tip: Use the [custom(_:size:relativeTo:)](https://developer.apple.com/documentation/swiftui/font/custom(_:size:relativeto:)) initializer of SwiftUI’s `Font` type to support dynamic type and ensure accessibility.

### Step 3

If needed, you can define different mappings for each platform. This is especially useful when using platform-specific fonts or sizes.

### Step 4

Once the font mapping is complete, add it to the `Theme` initializer, replacing the default Apple font mapping with your custom font mapping.

*Themes.swift*

```
import Theming

// MARK: - Available Themes
extension Theme {
    static let `default`: Theme = .createDefaultTheme()
}

// MARK: - Theme creation
extension Theme {
    private static func createDefaultTheme() -> Theme {
        // Color mapping
        let colors: Theme.ColorMap = // your color setup

            // Font mapping
            #if os(iOS) || os(visionOS)
            let fonts: Theme.FontMap = [
                ...,
            ]
            #elseif os(macOS)
            let fonts: Theme.FontMap = [
                ...,
            ]
            #elseif os(watchOS)
            let fonts: Theme.FontMap = [
                ...,
            ]
            #endif

        return Theme(name: colors, colors: fonts)
    }
}
```

### Step 5

The final step is to access the custom font in your views.

### Step 6

If your font supports different weights, you can use SwiftUI’s standard font modifiers to access these variants. Additionally, you can change the text color to one of the colors defined in your theme.

*ContentView.swift*

```
import SwiftUI
import Theming

struct ContentView: View {
    // MARK: - Body
    var body: some View {
        Text("Hello World")
            .themeFont(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(Color.themeColor(for: .primaryLabel))
    }
}
```