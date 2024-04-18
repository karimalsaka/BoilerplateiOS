import SwiftUI

enum AppRouter: NavigationRouter, Equatable {
    case main
    
    @ViewBuilder
    func view() -> some View {
        EmptyView()
    }

    var transition: NavigationTranisitionStyle {
        .push
    }
}
