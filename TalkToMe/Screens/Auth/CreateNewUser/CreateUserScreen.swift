//
//  CreateUserScreen.swift
//  TalkToMe
//
//  Created by Vlad on 5/8/24.
//

import SwiftUI

struct CreateUserScreen: View {
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
                VStack {
                    Text("Congrads!\nYour phone has verified successfully..")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                    
                    
                    Text("Now, create your own unique nickname, add your photo, or choose an avatar.")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(2)
                        .padding(.bottom)
                    Spacer()
                }
                .padding()
                .multilineTextAlignment(.center)
                .shadow(radius: 10)
                .transition(.opacity)
            }
            
            // Avatar Area
            VStack {
                ZStack {
                    Circle()
                        .padding()
                        .scaledToFit()
                        .frame(width: isKeyboardVisible ? 300 : 190, height: isKeyboardVisible ? 300 : 190)
                        .foregroundStyle(.white)
                        .opacity(0.5)
                        .shadow(radius: 10)
                    
                    
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: isKeyboardVisible ? 180 : 100, height: isKeyboardVisible ? 180 : 100)
                }
            }
            .padding(.bottom, isKeyboardVisible ? 200 : 160)
            
            HStack {
                Image(systemName: "number.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .fontWeight(.semibold)
                    .frame(width: 30)
                
                TextField("Username", text: $textFieldContent).font(.title3)
                    .shadow(radius: 10)
                    .onChange(of: textFieldContent) {oldValue, newValue in
                        if newValue.count >= 15 {
                            textFieldContent = String(newValue.prefix(15))
                        }
                    }
            }
            .foregroundStyle(.white)
            .padding()
            .background(Color.white.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.horizontal, 15)
            .padding(.top, isKeyboardVisible ? 200 : 90)
            
            
            VStack {
                Spacer()
                Button {
                    print("Button tapped!")
                } label: {
                    Text("Submit")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .medium))
                        .padding(.vertical, 18)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(textFieldContent.count >= 5 ? Color.yellow : Color.yellow.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
                }
                .disabled(textFieldContent.isEmpty || textFieldContent.count != 15)
                .frame(height: 100)
                .padding(.top, isKeyboardVisible ? 0 : 300)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                        withAnimation {
                            isKeyboardVisible = true
                        }
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                        withAnimation {
                            isKeyboardVisible = false
                        }
                    }
                    .padding()
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
    CreateUserScreen()
}

// MARK: - Hide Keyboard Function
extension View {
    func hiderKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
