import SwiftUI
import UIKit

protocol CoordinatorProtocol: AnyObject, ObservableObject {
    associatedtype Router: NavigationRouter
    
    var navigationController: UINavigationController { get }
    var startingRoute: Router? { get }
    
    func start()
    func show(_ route: Router, hideTabBar: Bool, hideNavBar: Bool, animated: Bool, environmentObjects: [any ObservableObject])
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func dismiss(animated: Bool)
}

open class Coordinator<Router: NavigationRouter>: NSObject, CoordinatorProtocol {
    var navigationController: UINavigationController
    var startingRoute: Router?
    
    public init(navigationController: UINavigationController = .init(), startingRoute: Router? = nil) {
        self.navigationController = navigationController
        self.startingRoute = startingRoute
    }
    
    public func start() {
        guard let route = startingRoute else { return }
        show(route)
    }
    
    public func show(_ route: Router, hideTabBar: Bool = false, hideNavBar: Bool = false, animated: Bool = true, environmentObjects: [any ObservableObject] = []) {
        let view = route.view()
        let environmentObjects = !environmentObjects.isEmpty ? environmentObjects : [self]
        let viewWithEnvironmentObjects = view.withEnvironmentObjects(environmentObjects)
        
        let viewController = UIHostingController(rootView: AnyView(viewWithEnvironmentObjects))
        viewController.view.frame = UIScreen.main.bounds
        
        navigationController.navigationBar.tintColor = .black
        
        if hideNavBar {
            navigationController.setNavigationBarHidden(true, animated: false)
        } else {
            navigationController.setNavigationBarHidden(false, animated: false)
        }
        
        if hideTabBar {
            viewController.hidesBottomBarWhenPushed = true
        } else {
            viewController.hidesBottomBarWhenPushed = false
        }
        
        switch route.transition {
        case .push:
            navigationController.pushViewController(viewController, animated: animated)
        case .presentModally:
            viewController.modalPresentationStyle = .formSheet
            navigationController.present(viewController, animated: animated)
        case .presentFullscreen:
            viewController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: animated)
        case .pushWithoutBackOption:
            navigationController.setViewControllers([viewController], animated: true)
        }
    }
    
    public func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    open func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: true) { [weak self] in
            self?.navigationController.viewControllers = []
        }
    }
}

extension View {
    func withEnvironmentObjects(_ environmentObjects: [any ObservableObject]) -> any View {
        var modifiedView = self as any View
        for object in environmentObjects {
            modifiedView = modifiedView.environmentObject(object) as any View
        }
        return modifiedView
    }
}
