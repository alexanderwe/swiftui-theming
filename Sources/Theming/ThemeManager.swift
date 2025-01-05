//
//  ThemeManager.swift
//  Theming
//
//  Created by Weiß, Alexander on 28.12.24.
//

import Observation
import SwiftUI

/// Manages the currently available theme in the app.
@Observable
@MainActor
public class ThemeManager {
    /// The selected theme.
    public var selectedTheme: Theme

    /// Create a new theme manager instance.
    ///
    /// - Parameters:
    ///   - initialTheme: The theme that is initially selected.
    public init(initialTheme: Theme) {
        self.selectedTheme = initialTheme
    }
}

extension Scene {
    /// Decorate a scene with a theme manager.
    ///
    /// Use this method to enable a scene to be themed. It will enable children to access the ``ThemeManager`` and the currently
    /// selected ``Theme`` instance in the Environment:
    ///
    /// ```swift
    /// import Theming
    ///
    /// struct MyView: View {
    ///    @Environment(\.theme) private var selectedTheme: Theme
    ///    @Environment(ThemeManager.self) private var themeManager: ThemeManager
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - themeManager: Theme manager to be used for theming this scene.
    /// - Returns: A new themed scene.
    public func withThemeManager(themeManager: ThemeManager) -> some Scene {
        ThemedScene(themeManager: themeManager) { self }
    }
}

// MARK: - ThemedScene
struct ThemedScene<Content: Scene>: Scene {
    // MARK: - State Properties
    /// The theme manager for this scene.
    @State private var themeManager: ThemeManager

    // MARK: - Properties
    /// The scene content
    private let scene: Content

    // MARK: - Initializer
    init(
        themeManager: ThemeManager,
        @SceneBuilder content: () -> Content
    ) {
        self._themeManager = State(initialValue: themeManager)
        self.scene = content()
    }

    // MARK: - Body
    var body: some Scene {
        scene
            .environment(themeManager)
            .environment(\.theme, themeManager.selectedTheme)
    }
}
