import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var coordinator: AuthenticationFlowCoordinator<AuthenticationFlowRouter>
    @StateObject private var viewModel: ResetPasswordViewModel

    init(viewModel: ResetPasswordViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
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
                    .background(Color.cyan)
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
    return SignUpWithEmailView(viewModel: viewModel)
}
