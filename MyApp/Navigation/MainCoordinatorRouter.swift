import SwiftUI

enum MainCoordinatorRouter: NavigationRouter, Equatable {
    case main
    
    @ViewBuilder
    func view() -> some View {
        EmptyView()
    }

    var transition: NavigationTranisitionStyle {
        .push
    }
}
