import SwiftUI

extension Font {
    static func designSystem(_ type: FontType) -> Font {
        switch type {
        case .heading1:
            return .system(size: 28, weight: .bold)
        case .heading2:
            return .system(size: 24, weight: .bold)
        case .heading3:
            return .system(size: 20, weight: .bold)
        case .heading4:
            return .system(size: 18, weight: .semibold)
        case .heading5:
            return .system(size: 16, weight: .semibold)
        case .body1:
            return .system(size: 16)
        case .body2:
            return .system(size: 14)
        case .body3:
            return .system(size: 12)
        case .body4:
            return .system(size: 10)
        case .button1:
            return .system(size: 20, weight: .semibold)
        case .button2:
            return .system(size: 18, weight: .semibold)
        case .button3:
            return .system(size: 16, weight: .semibold)
        }
    }
}
