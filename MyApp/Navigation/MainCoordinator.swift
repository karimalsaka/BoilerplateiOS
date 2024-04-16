import Foundation
import SwiftUI
import FirebaseAuth

class MainCoordinator<Router: NavigationRouter>: Coordinator<MainCoordinatorRouter> {
    private let authManager: AuthManager
    
    override init(navigationController: UINavigationController = .init(), startingRoute: MainCoordinatorRouter? = nil) {
        self.authManager = AuthManager()
        super.init(navigationController: navigationController, startingRoute: startingRoute)
    }
    
    public override func start() {
        if authManager.isUserSignedIn() {
            showMainAppFlow()
        } else {
            showLoginFlow()
        }
    }
    
    func showLoginFlow() {
        navigationController.setViewControllers([], animated: false)
        let coordinator = AuthenticationFlowCoordinator<AuthenticationFlowRouter>(navigationController: navigationController, mainCoordinator: self, authManager: authManager)
        coordinator.start()
    }
    
    func showMainAppFlow() {
        navigationController.setViewControllers([], animated: false)
        let coordinator = TabBarCoordinator<TabBarRouter>(navigationController: navigationController, mainCoordinator: self, authManager: authManager)
        coordinator.start()
    }
}
