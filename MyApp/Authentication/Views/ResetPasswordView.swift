import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var coordinator: AuthenticationFlowCoordinator<AuthenticationFlowRouter>
    @StateObject private var viewModel: ResetPasswordViewModel

    init(viewModel: ResetPasswordViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        VStack(spacing: 15) {
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.designSystem(.secondaryBackground).opacity(0.2))
                .cornerRadius(5)

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
                    .font(.designSystem(.button1))
                    .foregroundStyle(Color.designSystem(.primaryControlText))
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.designSystem(.primaryControlBackground))
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Reset Password")
    }
}

#Preview {
    let authManger = AuthManager()

    let viewModel = ResetPasswordViewModel(authManager: authManger)
    return ResetPasswordView(viewModel: viewModel)
}
