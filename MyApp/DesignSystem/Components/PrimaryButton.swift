import SwiftUI

struct PrimaryButton<Content: View>: View {
    let action: () -> Void
    let content: Content
    
    init(action: @escaping () -> Void, @ViewBuilder label: () -> Content) {
        self.action = action
        self.content = label()
    }
    
    var body: some View {
        Button(action: action, label: {
            content
                .font(.designSystem(.button1))
                .foregroundStyle(Color.designSystem(.primaryControlText))
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.designSystem(.primaryControlBackground))
                .cornerRadius(5)
        })
    }
}
