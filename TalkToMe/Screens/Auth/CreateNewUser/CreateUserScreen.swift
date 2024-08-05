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
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Background elements
            IntroGradient()
            
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
            
            // Avatar Area
            VStack {
                ZStack {
                    Circle()
                        .padding()
                        .scaledToFit()
                        .frame(width: 190, height: 190)
                        .foregroundStyle(.white)
                        .opacity(0.5)
                        .shadow(radius: 10)
                    
                    
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
            }
            .padding(.bottom, 160)
            
            HStack {
                Image(systemName: "person")
                    .fontWeight(.semibold)
                    .frame(width: 30)
                
                TextField("Username", text: $textFieldContent).font(.title3)
                    .shadow(radius: 10)
                    .onChange(of: textFieldContent) {oldValue, newValue in
                        if newValue.count > 15 {
                            textFieldContent = String(newValue.prefix(15))
                        }
                    }
                
            }
            .foregroundStyle(.white)
            .padding()
            .background(Color.white.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.horizontal, 15)
            .padding(.top, 90)
            
            
            VStack {
                Spacer()
                Button {
                    print("Button tapped!")
                } label: {
                    Text("Submit")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.vertical, 18)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(textFieldContent.count == 15 ? Color.yellow : Color.yellow.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .padding(.horizontal, 16)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
                }
                .disabled(textFieldContent.isEmpty || textFieldContent.count != 15)
                .frame(height: 100)
            }
        }
        .ignoresSafeArea(.keyboard)
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
