import SwiftUI

public enum NavigationTranisitionStyle {
    case push
    case presentModally
    case presentFullscreen
    case pushWithoutBackOption
}

public protocol NavigationRouter {
    
    associatedtype V: View
    var transition: NavigationTranisitionStyle { get }
    
    /// Creates and returns a view of assosiated type
    ///
    @ViewBuilder
    func view() -> V
}
