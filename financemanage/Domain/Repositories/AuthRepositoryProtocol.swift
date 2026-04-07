import Foundation

protocol AuthRepositoryProtocol {
    func signIn(request: SignInRequest) async throws -> AppUser
    func signUp(request: SignUpRequest) async throws -> AppUser
}
