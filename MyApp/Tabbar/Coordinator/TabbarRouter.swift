import SwiftUI

enum TabBarRouter: NavigationRouter, Equatable, CaseIterable {
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
    
    var imageName: String {
        switch self {
        case .home:
            return "house"
        case .settings:
            return "gear"
        }
    }
    
    var tabIndex: Int {
        return Self.allCases.firstIndex(of: self)!
    }

    var transition: NavigationTranisitionStyle {
        return .push
    }
    
    @MainActor @ViewBuilder
    func view() -> some View {
        EmptyView()
    }
}
