//
//  SettingsScreen.swift
//  ThemingDemo
//
//  Created by Weiß, Alexander on 28.12.24.
//

import SwiftUI
import Theming

struct SettingsScreen: View {
    // MARK: - Environment Properties
    @Environment(ThemeManager.self) private var themeManager

    var body: some View {
        @Bindable var themeManager = themeManager

        NavigationStack {
            Form {
                Section("Display Settings") {
                    Label {
                        Picker("Theme", selection: $themeManager.selectedTheme) {
                            Text("Default").tag(Theme.default)
                            Text("Custom").tag(Theme.custom)
                        }
                    } icon: {
                        Image(systemName: "paintpalette")
                    }

                    Button {
                        self.themeManager.selectedTheme = .custom
                    } label: {
                        Text("Ad hoc change to custom theme")
                    }
                }
            }
            #if os(iOS) || os(visionOS) || os(macOS)
            .scrollContentBackground(.hidden)
            .background(.themeColor(for: .primaryGroupedBackground))
            #endif
            .navigationTitle("Settings")
            #if os(iOS) || os(visionOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
        }
    }
}
