import Foundation
import SwiftUI

// MARK: - Hide Keyboard Function
extension View {
    func hiderKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
