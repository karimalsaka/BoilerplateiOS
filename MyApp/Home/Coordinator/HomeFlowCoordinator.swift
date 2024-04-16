import Foundation
import SwiftUI

class HomeFlowCoordinator<Router: NavigationRouter>: Coordinator<HomeFlowRouter> {
    private var tabbarCoordinator: TabBarCoordinator<TabBarRouter>?
    
    init(navigationController: UINavigationController = .init(), startingRoute: HomeFlowRouter? = nil, tabbarCoordinator: Coordinator<TabBarRouter>? = nil) {
        self.tabbarCoordinator = tabbarCoordinator as? TabBarCoordinator<TabBarRouter>
        super.init(navigationController: navigationController, startingRoute: startingRoute)
    }
    
    // Override the base Coordinator's show() function because the environmentObject needs to be of type HomeCoordinator and not BaseCoordinator
    public override func show(_ route: HomeFlowRouter, hideTabBar: Bool = false, hideNavBar: Bool = false, animated: Bool = true, environmentObjects: [any ObservableObject] = []) {
        var environmentObjects: [any ObservableObject] = environmentObjects
        environmentObjects.append(self)
        super.show(route, hideTabBar: hideTabBar, animated: animated, environmentObjects: environmentObjects)
    }
}
