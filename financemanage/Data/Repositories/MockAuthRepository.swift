import Foundation

enum AuthRepositoryError: LocalizedError {
    case invalidCredentials

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid credentials. Try demo@payu.com / 123456"
        }
    }
}

final class MockAuthRepository: AuthRepositoryProtocol {
    func signIn(request: SignInRequest) async throws -> AppUser {
        try await Task.sleep(nanoseconds: 350_000_000)
        if request.email.lowercased() == "demo@payu.com", request.password == "123456" {
            return AppUser(id: UUID(), fullName: "Alex", email: request.email)
        }
        throw AuthRepositoryError.invalidCredentials
    }

    func signUp(request: SignUpRequest) async throws -> AppUser {
        try await Task.sleep(nanoseconds: 450_000_000)
        return AppUser(id: UUID(), fullName: request.fullName, email: request.email)
    }
}
