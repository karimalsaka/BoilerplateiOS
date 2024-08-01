import SwiftUI
import RevenueCat

@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init() {
        /// Pass your RevenueCat api key here
//        Purchases.configure(withAPIKey: "REVENUE_CAT_API_KEY_HERE")
    }

    var body: some Scene {
        WindowGroup {
            NavigationController()
                .ignoresSafeArea()
        }
    }
}

struct NavigationController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = UINavigationController()
        let coordinator = AppCoordinator<AppRouter>(navigationController: navigationController)
        
        coordinator.start()
        return coordinator.navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // No updates needed for now
    }
}
