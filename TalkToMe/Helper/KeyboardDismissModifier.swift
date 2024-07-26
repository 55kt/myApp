//
//  KeyboardDismissModifier.swift
//  TalkToMe
//
//  Created by Vlad on 26/7/24.
//

import SwiftUI

struct KeyboardDismissModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil,
                            from: nil,
                            for: nil
                        )
                    }
            )
    }
}

extension View {
    func hideKeyboardOnTap() -> some View {
        self.modifier(KeyboardDismissModifier())
    }
}
