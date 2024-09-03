//
//  FocusedTextField.swift
//  TalkToMe
//
//  Created by Vlad on 1/8/24.
//

import SwiftUI

struct FocusedTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: FocusedTextField

        init(parent: FocusedTextField) {
            self.parent = parent
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.parent.isFirstResponder = true
            }
        }
    }

    @Binding var text: String
    @Binding var isFirstResponder: Bool

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.placeholder = "Search Country"

        if isFirstResponder {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
}
