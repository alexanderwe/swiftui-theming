import SwiftUI
import Theming

@main
struct MyApp: App {
    @State var themeManager: ThemeManager = ThemeManager(initialTheme: .default)

    var body: some Scene {
        ...
    }
}
