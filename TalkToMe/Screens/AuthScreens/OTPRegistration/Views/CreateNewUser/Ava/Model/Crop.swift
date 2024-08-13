import SwiftUI

// MARK: - Crop config

enum Crop: Equatable {
    case circle
    case custom(CGSize)
    
    func name() -> String {
        switch self {
        case .circle:
            return "circle"
        case let .custom(cGSize):
            return "Custom \(Int(cGSize.width))X\(Int(cGSize.width))"
        }
    }
    
    func size() -> CGSize {
        switch self {
        case .circle:
            return .init(width: 350, height: 350)
        case let .custom(cGSize):
            return cGSize
        }
    }
}
