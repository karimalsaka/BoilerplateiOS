import SwiftUI

extension Color {
    static func designSystem(_ name: ColorName) -> Color {
        return Color(name.rawValue)
    }
}
