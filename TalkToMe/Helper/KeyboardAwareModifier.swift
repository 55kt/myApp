//
//  KeyboardAwareModifier.swift
//  TalkToMe
//
//  Created by Vlad on 2/8/24.
//

import SwiftUI
import Combine

struct KeyboardAwareModifier: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0
    @State private var cancellable: AnyCancellable?

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onAppear {
                self.cancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
                    .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
                    .compactMap { notification in
                        guard let userInfo = notification.userInfo else { return nil }
                        return (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height
                    }
                    .assign(to: \.keyboardHeight, on: self)
            }
            .onDisappear {
                self.cancellable?.cancel()
            }
    }
}

extension View {
    func keyboardAware() -> some View {
        self.modifier(KeyboardAwareModifier())
    }
}
