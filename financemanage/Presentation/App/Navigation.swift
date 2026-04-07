import SwiftUI
import Combine

enum Destination: Hashable {
    case login
    case home
    case settings
    case chat(conversationId: String)
}

enum AppState {
    case unauthenticated
    case authenticated
    case pushnotification
}

final class Router: ObservableObject {
    @Published var navPath = NavigationPath()
    @Published var currentAppState: AppState
    @Published var currentNavHistory: [Destination] = []

    private let sessionManager: SessionManager

    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
        if sessionManager.isAuthenticated {
            currentAppState = .authenticated
            currentNavHistory = [.home]
        } else {
            currentAppState = .unauthenticated
            currentNavHistory = [.login]
        }
    }

    func navigate(to destination: Destination) {
        navPath.append(destination)
        currentNavHistory.append(destination)
    }

    func navigateBack() {
        guard !navPath.isEmpty else { return }
        navPath.removeLast()
        if !currentNavHistory.isEmpty {
            currentNavHistory.removeLast()
        }
    }

    func navigateBack(count: Int) {
        let removeCount = min(count, navPath.count)
        guard removeCount > 0 else { return }
        navPath.removeLast(removeCount)
        currentNavHistory.removeLast(min(removeCount, currentNavHistory.count))
    }

    func navigateBack(to destination: Destination) {
        if let lastIndex = currentNavHistory.lastIndex(of: destination) {
            let removeCount = currentNavHistory.count - lastIndex - 1
            if removeCount > 0 {
                navPath.removeLast(removeCount)
                currentNavHistory.removeLast(removeCount)
            }
        }
    }

    func navigateToRoot() {
        if !navPath.isEmpty {
            navPath.removeLast(navPath.count)
        }
    }

    func replace(with destination: Destination) {
        navigateToRoot()
        navPath.append(destination)
        currentNavHistory = [destination]
    }

    func updateAppState(to state: AppState, conversationId: String = "") {
        currentAppState = state
        navigateToRoot()
        updateNavigationHistoryForAppState(conversationId: conversationId)
    }

    func completeSignIn() {
        sessionManager.signIn()
        updateAppState(to: .authenticated)
    }

    func completeSignOut() {
        sessionManager.signOut()
        updateAppState(to: .unauthenticated)
    }

    private func updateNavigationHistoryForAppState(conversationId: String) {
        switch currentAppState {
        case .authenticated:
            currentNavHistory = [.home]
        case .unauthenticated:
            currentNavHistory = [.login]
        case .pushnotification:
            guard !conversationId.isEmpty else { return }
            currentNavHistory = [.chat(conversationId: conversationId)]
        }
    }
}

extension View {
    func navigationDestination() -> some View {
        self.navigationDestination(for: Destination.self) { destination in
            switch destination {
            case .login:
                AuthView()
            case .home:
                MainTabView()
            case .settings:
                SettingsView()
            case .chat(let conversationId):
                ChatView(conversationId: conversationId)
            }
        }
    }
}
