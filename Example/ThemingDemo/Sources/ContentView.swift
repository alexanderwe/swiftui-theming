//
//  ContentView.swift
//  ThemingDemo
//
//  Created by Weiß, Alexander on 28.12.24.
//

import SwiftUI
import Theming

struct ContentView: View {
    var body: some View {
        #if os(macOS)
        HomeScreen()
        #else
        TabView {
            Tab("Home", systemImage: "house") {
                HomeScreen()
            }

            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }
        }
        #endif
    }
}

#Preview {
    ContentView()
}
