import SwiftUI

extension View {
    /// For making at easey and simple to use
    @ViewBuilder
    func frame(_ size: CGSize) -> some View {
        self
            .frame(width: size.width, height: size.height)
    }
}

/// - Haptic Feedback
func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}
