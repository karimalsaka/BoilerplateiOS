import SwiftUI
import AuthenticationServices
import CryptoKit

@MainActor
final class AuthenticationOptionsViewModel:NSObject, ObservableObject {
    var authManager: AuthManager
    var didSignInWithAppleSuccessfully = false

    private var currentNonce: String?
    private var presentationAnchor: ASPresentationAnchor?

    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    func startSignInWithAppleFlow(presentationAnchor: ASPresentationAnchor?) {
        guard let presentationAnchor else {
            return
        }
        self.presentationAnchor = presentationAnchor
        
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension AuthenticationOptionsViewModel: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return presentationAnchor!
    }
}

extension AuthenticationOptionsViewModel: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let appleIDToken = appleIDCredential.identityToken,
              let idTokenString = String(data: appleIDToken, encoding: .utf8),
              let nonce = currentNonce else {
            print("error")
            return
        }
        
        let tokens = SignInWithAppleResult(token: idTokenString, nonce: nonce)
        
        Task {
            try await authManager.signInWithApple(tokens: tokens)
            didSignInWithAppleSuccessfully = true
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }

    //MARK: - Helper functions
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }
    
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }

}

struct AuthenticationOptionsView: View {
    @EnvironmentObject var coordinator: AuthenticationFlowCoordinator<AuthenticationFlowRouter>
    @StateObject private var viewModel: AuthenticationOptionsViewModel
    
    init(viewModel: AuthenticationOptionsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    // replace with image lol
                    Rectangle()
                        .frame(height: 300)
                        .foregroundStyle(Color.cyan)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.top, 30)
                        .padding(.bottom, 50)
                     Spacer()

                    Button {
                        coordinator.show(.signUpWithEmail(authManager: viewModel.authManager))
                    } label: {
                        Text("Sign Up with Email")
                            .font(.headline)
                            .foregroundStyle(Color.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.cyan)
                            .cornerRadius(10)
                    }

                    Button {
                        coordinator.show(.signInWithEmail(authManager: viewModel.authManager))
                    } label: {
                        Text("Sign In with Email")
                            .font(.headline)
                            .foregroundStyle(Color.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.cyan)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        coordinator.show(.resetPassword(authManager: viewModel.authManager))
                    } label: {
                        Text("Forgot Password?")
                            .font(.headline)
                            .foregroundStyle(Color.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                     
                    Button {
                        viewModel.startSignInWithAppleFlow(presentationAnchor: coordinator.navigationController.topViewController?.view.window)
                    } label: {
                        AppleButtonView(type: .continue, style: .black)
                            .allowsHitTesting(false)
                            .frame(height: 55)
                    }
                    
                     Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChange(of: viewModel.didSignInWithAppleSuccessfully) { success in
                if success {
                    coordinator.userSignedIn()
                }
            }
    }
}

#Preview {
    let authManager = AuthManager()
    let viewModel = AuthenticationOptionsViewModel(authManager: authManager)

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
