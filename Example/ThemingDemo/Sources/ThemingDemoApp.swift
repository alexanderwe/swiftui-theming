//
//  ThemingDemoApp.swift
//  ThemingDemo
//
//  Created by Weiß, Alexander on 28.12.24.
//

import SwiftUI
import Theming

@main
struct ThemingDemoApp: App {
    // MARK: - State Properties
    @State var myThemeManager: ThemeManager = ThemeManager(initialTheme: .default)

    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .withThemeManager(themeManager: myThemeManager)

        #if os(macOS)
        Settings {
            SettingsScreen()
                .scenePadding()
                .frame(maxWidth: 350, minHeight: 100)
        }
        .withThemeManager(themeManager: myThemeManager)
        #endif
    }
}
