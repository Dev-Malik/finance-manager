import SwiftUI

struct SettingsView: View {
    var body: some View {
        Text("Settings")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppPalette.screenBackground.ignoresSafeArea())
            .foregroundStyle(.white)
    }
}
