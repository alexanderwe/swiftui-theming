//
//  HomeScreen.swift
//  ThemingDemo
//
//  Created by Weiß, Alexander on 28.12.24.
//

import SwiftUI
import Theming

struct HomeScreen: View {
    // MARK: - State Properties
    @State private var isSheetPresented: Bool = false

    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                Section("Color Theming") {
                    Text("Hello World")
                        .foregroundStyle(.themeColor(for: .primaryLabel))
                }

                Section("Font Theming") {
                    Text("Hello World")
                        .themeFont(.largeTitle)
                        .fontWeight(.bold)
                }

                Section("Sheet theming") {
                    Button {
                        self.isSheetPresented.toggle()
                    } label: {
                        Text("Toggle Sheet to view theming in a sheet")
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                SheetScreen()
            }
            .navigationTitle("Home")
            #if os(iOS) || os(visionOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
        }
    }
}

// MARK: - Sheet
struct SheetScreen: View {
    var body: some View {
        VStack {
            Text("Sheet")
                .themeFont(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.themeColor(for: .primaryLabel))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(.themeColor(for: .primaryGroupedBackground))
    }
}
