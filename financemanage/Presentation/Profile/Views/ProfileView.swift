import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(.white.opacity(0.9))

                Text("Alex")
                    .font(.title.bold())
                    .foregroundStyle(.white)

                Text("Fintech demo profile")
                    .foregroundStyle(AppTheme.mutedText)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppTheme.screenBackground.ignoresSafeArea())
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
