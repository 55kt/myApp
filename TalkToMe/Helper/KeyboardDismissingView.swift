import SwiftUI

struct KeyboardDismissingView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIScrollView {
        let scroll = UIScrollView()
        scroll.keyboardDismissMode = .interactive
        return scroll
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {}
}
