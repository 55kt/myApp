import SwiftUI

enum Crop: Equatable {
    case circle
    case camera

    func name() -> String {
        switch self {
        case .circle:
            return "circle"
        case .camera: 
            return "Take a Photo"
        }
    }

    func size() -> CGSize {
        switch self {
        case .circle:
            return .init(width: 350, height: 350)
        case .camera:
            return .init(width: 350, height: 350)
        }
    }
}
