import SwiftUI

// Function for adding tail
private struct BubbleTailModifier: ViewModifier {
    var direction: MessageDirection
    
    func body(content: Content) -> some View {
        content.overlay(alignment: direction == .received ? .bottomLeading : .bottomTrailing) {
            BubbleTail(direction: direction)
        }
    }
}

// Extension for adding tail
extension View {
    func applyTail(direction: MessageDirection) -> some View {
        self.modifier(BubbleTailModifier(direction: direction))
    }
}
