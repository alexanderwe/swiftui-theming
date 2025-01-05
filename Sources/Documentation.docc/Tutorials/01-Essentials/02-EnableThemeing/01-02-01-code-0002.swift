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
