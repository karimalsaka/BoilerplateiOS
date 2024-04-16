import SwiftUI

@MainActor
final class SignUpWithEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    private var authManager: AuthManager

    init(authManager: AuthManager) {
        self.authManager = authManager
    }

    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        try await authManager.createUser(email: email, password: password)
    }
}

struct SignUpWithEmailView: View {
    @EnvironmentObject var coordinator: AuthenticationFlowCoordinator<AuthenticationFlowRouter>
    @StateObject private var viewModel: SignUpWithEmailViewModel

    init(viewModel: SignUpWithEmailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            
            Button {
                Task {
                    do {
                        try await viewModel.signUp()
                        coordinator.userSignedIn()
                    } catch {
                        //MARK: show error alert to user
                        print("failed to sign up with error \(error)")
                    }
                }
                
            } label: {
                Text("Create account")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Sign up with email")
    }
}

#Preview {
    let authManger = AuthManager()
    let viewModel = SignUpWithEmailViewModel(authManager: authManger)
    return SignUpWithEmailView(viewModel: viewModel)
}
