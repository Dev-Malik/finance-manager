import Foundation

enum AuthMode: String, CaseIterable {
    case signIn
    case signUp
}

struct SignInRequest {
    var email: String = ""
    var password: String = ""
}

struct SignUpRequest {
    var fullName: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
}

struct AppUser {
    let id: UUID
    let fullName: String
    let email: String
}
