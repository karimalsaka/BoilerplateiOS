import Foundation
import SwiftUI
import FirebaseAuth

class AppCoordinator<Router: NavigationRouter>: Coordinator<AppRouter> {
    private let authManager: AuthManager
    let userManager: UserManager
    
    override init(navigationController: UINavigationController = .init(), startingRoute: AppRouter? = nil) {
        self.authManager = AuthManager()
        self.userManager = UserManager()
        super.init(navigationController: navigationController, startingRoute: startingRoute)
    }
    
    public override func start() {
        if authManager.isUserSignedIn() {
            Task {
                await PurchasesManager.shared.getSubscriptionStatus()
            }
            showMainAppFlow()
        } else {
            showLoginFlow()
        }
    }
    
    func showLoginFlow() {
        navigationController.setViewControllers([], animated: false)
        let coordinator = AuthenticationFlowCoordinator<AuthenticationFlowRouter>(
            navigationController: navigationController,
            appCoordinator: self,
            authManager: authManager,
            userManager: userManager
        )
        coordinator.start()
    }
    
    func showMainAppFlow() {
        navigationController.setViewControllers([], animated: false)
        let coordinator = TabBarCoordinator<TabBarRouter>(
            navigationController: navigationController,
            appCoordinator: self,
            authManager: authManager,
            userManager: userManager
        )
        coordinator.start()
    }
}
