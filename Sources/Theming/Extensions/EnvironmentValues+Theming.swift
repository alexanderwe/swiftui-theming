//
//  EnvironmentValues+Theming.swift
//  Theming
//
//  Created by Weiß, Alexander on 28.12.24.
//

public import SwiftUI

#if os(iOS) || os(visionOS)
struct UserInterfaceLevel: EnvironmentKey {
    static var defaultValue: UIUserInterfaceLevel {
        return UITraitCollection.current.userInterfaceLevel
    }
}

extension EnvironmentValues {
    /// The current interface level for this environment.
    var userInterfaceLevel: UIUserInterfaceLevel {
        self[UserInterfaceLevel.self]
    }
}
#endif

extension EnvironmentValues {
    /// The currently active theme in this environment.
    @Entry public var theme: Theme?
}
