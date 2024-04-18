import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
    let navigationController = UINavigationController()
    let coordinator = AppCoordinator<AppRouter>(navigationController: navigationController)
      
    coordinator.start()
    
    return true
  }
}
