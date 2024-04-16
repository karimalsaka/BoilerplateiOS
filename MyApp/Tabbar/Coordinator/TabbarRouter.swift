import SwiftUI

enum TabBarRouter: NavigationRouter, Equatable {
    case home
    case settings
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .settings:
            return "Settings"
        }
    }
    
//    var imageName: String {
//        switch self {
//        case .home:
//            return "ic_search_white"
//        case .settings:
//            return "ic_home"
//        }
//    }
    
    var tabIndex: Int {
        switch self {
        case .home:
            return 0
        case .settings:
            return 1
        }
    }

    var transition: NavigationTranisitionStyle {
        switch self {

        case .home, .settings:
            return .push
        }
    }
    
    @MainActor @ViewBuilder
    func view() -> some View {
        switch self {
        case .home:
            EmptyView()
        case .settings:
            EmptyView()
        }
    }
}
