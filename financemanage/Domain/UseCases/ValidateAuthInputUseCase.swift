import Foundation

enum AuthValidationError: LocalizedError {
    case invalidEmail
    case weakPassword
    case emptyName
    case passwordMismatch

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Please enter a valid email."
        case .weakPassword:
            return "Password must be at least 6 characters."
        case .emptyName:
            return "Full name is required."
        case .passwordMismatch:
            return "Password and confirm password must match."
        }
    }
}

struct ValidateAuthInputUseCase {
    func validateSignIn(_ input: SignInRequest) throws {
        guard input.email.contains("@"), input.email.contains(".") else {
            throw AuthValidationError.invalidEmail
        }
        guard input.password.count >= 6 else {
            throw AuthValidationError.weakPassword
        }
    }

    func validateSignUp(_ input: SignUpRequest) throws {
        guard !input.fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw AuthValidationError.emptyName
        }
        guard input.email.contains("@"), input.email.contains(".") else {
            throw AuthValidationError.invalidEmail
        }
        guard input.password.count >= 6 else {
            throw AuthValidationError.weakPassword
        }
        guard input.password == input.confirmPassword else {
            throw AuthValidationError.passwordMismatch
        }
    }
}
