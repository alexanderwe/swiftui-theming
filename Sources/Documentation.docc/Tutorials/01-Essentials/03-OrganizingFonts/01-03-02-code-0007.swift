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
