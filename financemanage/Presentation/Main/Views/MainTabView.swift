import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            TransactionsView()
                .tabItem {
                    Label("Balances", systemImage: "wallet.pass.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .tint(.white)
    }
}

#Preview {
    MainTabView()
}
