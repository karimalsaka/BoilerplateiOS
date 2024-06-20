import SwiftUI

struct SecondaryButton<Content: View>: View {
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
                .tint(.blue)
                .foregroundStyle(Color.designSystem(.primaryControlBackground))
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 27.5)
                        .stroke(Color.designSystem(.primaryControlBackground), lineWidth: 1)
                )
        })
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(action: {
        }) {
            Text("Secondary Button")
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .previewDisplayName("Primary Button")
    }
}
