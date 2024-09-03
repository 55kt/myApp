//
//  FocusedModifier.swift
//  TalkToMe
//
//  Created by Vlad on 2/8/24.
//

import SwiftUI

struct FocusedModifier: ViewModifier {
    @Binding var isFocused: Bool

    func body(content: Content) -> some View {
        content
            .background(FocusedView(isFocused: $isFocused))
    }

    private struct FocusedView: UIViewRepresentable {
        @Binding var isFocused: Bool

        func makeUIView(context: Context) -> UIView {
            let view = UIView()
            DispatchQueue.main.async {
                if self.isFocused {
                    view.becomeFirstResponder()
                } else {
                    view.resignFirstResponder()
                }
            }
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {}
    }
}

extension View {
    func focused(_ isFocused: Binding<Bool>) -> some View {
        self.modifier(FocusedModifier(isFocused: isFocused))
    }
}
