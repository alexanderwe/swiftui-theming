import SwiftUI
import Theming

struct ThemeChangerView: View {
    // MARK: - Environment Properties
    @Environment(ThemeManager.self) private var themeManager

    var body: some View {
        @Bindable var themeManager = themeManager
    }
}
