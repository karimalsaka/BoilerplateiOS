import SwiftUI
import AuthenticationServices

struct AuthenticationOptionsView: View {
    @EnvironmentObject var coordinator: AuthenticationFlowCoordinator<AuthenticationFlowRouter>
    @StateObject private var viewModel: AuthenticationOptionsViewModel
    
    init(viewModel: AuthenticationOptionsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
            ScrollView {
                VStack(alignment: .center, spacing: 10) {
                    
                    // replace with image
                    Rectangle()
                        .frame(height: 300)
                        .foregroundStyle(Color.cyan)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top, 30)
                        .padding(.bottom, 15)

                    Text("Build you million dollar idea in days")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)

                    Button {
                        viewModel.startSignInWithAppleFlow(presentationAnchor: coordinator.navigationController.topViewController?.view.window)
                    } label: {
                        AppleButtonView(type: .continue, style: .black)
                            .allowsHitTesting(false)
                            .frame(height: 55)
                    }

                    Button {
                        coordinator.show(.signInWithEmail(authManager: viewModel.authManager, userManager: viewModel.userManager))
                    } label: {
                        Text("Sign In with Email")
                            .font(.headline)
                            .foregroundStyle(Color.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.cyan)
                            .cornerRadius(5)
                    }
                    
                    Text("or")
                        .font(.system(size: 15, weight: .regular))
                        .padding(.vertical, 5)
                    
                    Button {
                        coordinator.show(.signUpWithEmail(authManager: viewModel.authManager, userManager: viewModel.userManager))
                    } label: {
                        Text("Sign Up with Email")
                            .font(.headline)
                            .foregroundStyle(Color.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.cyan)
                            .cornerRadius(5)
                    }
                     
                     Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChange(of: viewModel.didSignInWithAppleSuccessfully) { _, success in
                if success {
                    coordinator.userSignedIn()
                }
            }
            .onChange(of: viewModel.appleSignInError) { _, error in
                guard let error else { return }
                                
                coordinator.showErrorAlert("Failed to sign in with error: \n \(error.localizedDescription)")
            }
    }
}

#Preview {
    let authManager = AuthManager()
    let userManager = UserManager()
    
    let viewModel = AuthenticationOptionsViewModel(
        authManager: authManager,
        userManager: userManager
    )

    return AuthenticationOptionsView(viewModel: viewModel)
}

struct AppleButtonView: UIViewRepresentable {
    let type: ASAuthorizationAppleIDButton.ButtonType
    let style: ASAuthorizationAppleIDButton.Style
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let authorization = ASAuthorizationAppleIDButton(authorizationButtonType: type, authorizationButtonStyle: style)
        return authorization
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}
