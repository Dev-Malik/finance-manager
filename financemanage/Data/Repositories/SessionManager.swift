import Foundation
import Combine

final class SessionManager: ObservableObject {
    static let shared = SessionManager()

    @Published var isAuthenticated: Bool = false

    private init() {}

    func signIn() {
        isAuthenticated = true
    }

    func signOut() {
        isAuthenticated = false
    }
}
