import SwiftUI

@main
struct MyAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationController()
        }
    }
}

struct NavigationController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = UINavigationController()
        let coordinator = MainCoordinator<MainCoordinatorRouter>(navigationController: navigationController)
        
        coordinator.start()
        return coordinator.navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // No updates needed for now
    }
}
