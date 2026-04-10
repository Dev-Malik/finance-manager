import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    @EnvironmentObject private var router: Router
    @FocusState private var focusedField: Field?

    private enum Field {
        case signInEmail
        case signInPassword
        case fullName
        case signUpEmail
        case signUpPassword
        case confirmPassword
    }

    var body: some View {
        authContent
        .preferredColorScheme(.dark)
        .onChange(of: viewModel.currentUser?.id) { _, newValue in
            if newValue != nil {
                router.completeSignIn()
            }
        }
    }

    private var authContent: some View {
        GeometryReader { proxy in
            ZStack {
                AppPalette.screenBackground
                    .ignoresSafeArea()

                VStack(spacing: 18) {
                    iconHeader
                    card
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 22)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .scrollDismissesKeyboard(.interactively)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { focusedField = nil }
            }
        }
    }

    private var iconHeader: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.white)
                .frame(width: 52, height: 52)
                .overlay {
                    Text("P")
                        .font(.headline.weight(.bold))
                        .foregroundStyle(.black)
                }

            Text("Welcome to PayU")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(AppPalette.primaryText)

            Text("Send money globally with the real exchange rate")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(AppPalette.secondaryText)
        }
        .padding(.bottom, 4)
    }

    private var card: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Get started")
                .font(.system(size: 30, weight: .semibold))
                .foregroundStyle(AppPalette.primaryText)

            Text("Sign in to your account or create a new one")
                .font(.title3)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(AppPalette.secondaryText)

            modeSegment

            if viewModel.mode == .signIn {
                signInFields
            } else {
                signUpFields
            }

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red.opacity(0.9))
                    .font(.subheadline)
            }

            Button {
                focusedField = nil
                Task { await viewModel.submit() }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                } else {
                    Text(viewModel.submitButtonTitle)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
            }
            .background(Color.white)
            .foregroundStyle(.black)
            .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
            .disabled(viewModel.isLoading)
        }
        .padding(14)
        .background(AppPalette.cardBackground)
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(AppPalette.cardBorder, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var modeSegment: some View {
        HStack(spacing: 6) {
            modeButton(title: "Sign In", mode: .signIn)
            modeButton(title: "Sign Up", mode: .signUp)
        }
        .padding(5)
        .background(Color.white.opacity(0.09))
        .clipShape(Capsule())
    }

    private func modeButton(title: String, mode: AuthMode) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.mode = mode
                viewModel.errorMessage = nil
            }
        } label: {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(viewModel.mode == mode ? Color.white : Color.clear)
                .foregroundStyle(viewModel.mode == mode ? .black : .white.opacity(0.8))
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }

    private var signInFields: some View {
        VStack(spacing: 12) {
            labeledField(title: "Email") {
                TextField("Enter your email", text: $viewModel.signIn.email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .signInEmail)
            }

            labeledField(title: "Password") {
                passwordInput(
                    placeholder: "Enter your password",
                    text: $viewModel.signIn.password,
                    isVisible: $viewModel.isPasswordVisible,
                    field: .signInPassword
                )
            }

            HStack {
                Spacer()
                Text("Forgot password?")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.white.opacity(0.8))
            }
        }
    }

    private var signUpFields: some View {
        VStack(spacing: 12) {
            labeledField(title: "Full Name") {
                TextField("Enter your full name", text: $viewModel.signUp.fullName)
                    .textInputAutocapitalization(.words)
                    .focused($focusedField, equals: .fullName)
            }

            labeledField(title: "Email") {
                TextField("Enter your email", text: $viewModel.signUp.email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .signUpEmail)
            }

            labeledField(title: "Password") {
                passwordInput(
                    placeholder: "Create a password",
                    text: $viewModel.signUp.password,
                    isVisible: $viewModel.isPasswordVisible,
                    field: .signUpPassword
                )
            }

            labeledField(title: "Confirm Password") {
                passwordInput(
                    placeholder: "Confirm your password",
                    text: $viewModel.signUp.confirmPassword,
                    isVisible: $viewModel.isConfirmPasswordVisible,
                    field: .confirmPassword
                )
            }
        }
    }

    private func labeledField<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundStyle(AppPalette.primaryText.opacity(0.9))
            content()
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(AppPalette.inputBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .foregroundStyle(AppPalette.primaryText)
        }
    }

    private func passwordInput(
        placeholder: String,
        text: Binding<String>,
        isVisible: Binding<Bool>,
        field: Field
    ) -> some View {
        HStack {
            Group {
                if isVisible.wrappedValue {
                    TextField(placeholder, text: text)
                } else {
                    SecureField(placeholder, text: text)
                }
            }
            .focused($focusedField, equals: field)

            Button {
                isVisible.wrappedValue.toggle()
            } label: {
                Image(systemName: isVisible.wrappedValue ? "eye.slash" : "eye")
                    .foregroundStyle(Color.white.opacity(0.6))
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    AuthView()
        .environmentObject(Router(sessionManager: SessionManager.shared))
}
