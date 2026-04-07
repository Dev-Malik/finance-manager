import Foundation
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var mode: AuthMode = .signIn
    @Published var signIn = SignInRequest()
    @Published var signUp = SignUpRequest()
    @Published var isPasswordVisible = false
    @Published var isConfirmPasswordVisible = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var currentUser: AppUser?

    private let authRepository: AuthRepositoryProtocol
    private let validator: ValidateAuthInputUseCase

    init(
        authRepository: AuthRepositoryProtocol = MockAuthRepository(),
        validator: ValidateAuthInputUseCase = ValidateAuthInputUseCase()
    ) {
        self.authRepository = authRepository
        self.validator = validator
    }

    var submitButtonTitle: String {
        mode == .signIn ? "Sign In" : "Create Account"
    }

    func submit() async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }

        do {
            switch mode {
            case .signIn:
                try validator.validateSignIn(signIn)
                currentUser = try await authRepository.signIn(request: signIn)
            case .signUp:
                try validator.validateSignUp(signUp)
                currentUser = try await authRepository.signUp(request: signUp)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
