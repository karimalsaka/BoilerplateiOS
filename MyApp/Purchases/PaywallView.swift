import SwiftUI
import RevenueCatUI

struct PaywallView: View {
    var body: some View {
        RevenueCatUI.PaywallView(displayCloseButton: true)
    }
}

#Preview {
    PaywallView()
}
