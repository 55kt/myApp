//
//  CreateUserScreen.swift
//  TalkToMe
//
//  Created by Vlad on 5/8/24.
//

import SwiftUI

struct CreateUserScreenView: View {
    // MARK: - Properties
    @State private var keyboardHeight: CGFloat = 0
    @State private var textFieldContent: String = ""
    @State private var isKeyboardVisible: Bool = false
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Background elements
            IntroGradient()
            
            if !isKeyboardVisible {
                // Nav text area
                NavigationTextArea()
            }
            
            // Avatar Area
            UserAvatar(boolPlaceholder: $isKeyboardVisible)
            
            // Username TextField
            UsernameField(textPlaceholder: $textFieldContent, boolPlaceholder: $isKeyboardVisible)
            
            // Submit Button
            SubmitButton(textPlaceholder: $textFieldContent, boolPlaceholder: $isKeyboardVisible)
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            hiderKeyboard()
        }
        .animation(.easeOut(duration: 0.3), value: keyboardHeight)
    }
}

// MARK: - Preview
#Preview {
    CreateUserScreenView()
}
