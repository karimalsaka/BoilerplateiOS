import SwiftUI

@MainActor
final class ResetPasswordViewModel: ObservableObject {
    @Published var email = ""
    
    private var authManager: AuthManager

    init(authManager: AuthManager) {
        self.authManager = authManager
    }

    func resetPassword() async throws {
        guard !email.isEmpty else {
            return
        }
        
        try await authManager.resetPassword(email: email)
    }
}

struct ResetPasswordView: View {
    @StateObject private var viewModel: ResetPasswordViewModel
    @Binding private var shouldShowSignIn: Bool

    init(viewModel: ResetPasswordViewModel, shouldShowSignIn: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._shouldShowSignIn = shouldShowSignIn
    }
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                        
            Button {
                Task {
                    do {
                        try await viewModel.resetPassword()
                    } catch {
                        //MARK: show error alert to user
                        print("failed to send reset password email with error \(error)")
                    }
                }
                
            } label: {
                Text("Send Reset Password email")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Reset Password")
    }
}

#Preview {
    let authManger = AuthManager()
    let viewModel = SignUpWithEmailViewModel(authManager: authManger)
    return SignUpWithEmailView(viewModel: viewModel, shouldShowSignIn: .constant(false))
}
