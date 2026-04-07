import SwiftUI

struct AppRootView: View {
    @StateObject private var router = Router(sessionManager: SessionManager.shared)

    var body: some View {
        NavigationStack(path: $router.navPath) {
            Group {
                switch router.currentAppState {
                case .unauthenticated:
                    AuthView()
                case .authenticated:
                    MainTabView()
                case .pushnotification:
                    ChatView(conversationId: "push-default")
                }
            }
            .navigationDestination()
        }
        .environmentObject(router)
    }
}

#Preview {
    AppRootView()
}
