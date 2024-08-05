//
//  CreateUserScreen.swift
//  TalkToMe
//
//  Created by Vlad on 5/8/24.
//

import SwiftUI

struct CreateUserScreen: View {
    // MARK: - Properties
    @State var username: String
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Background elements
            IntroGradient()
            //            OpacityBackgroundLogo()Us
            
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
            
            
            VStack {
                ZStack {
                    Circle()
                        .padding()
                        .scaledToFit()
                        .frame(width: 230, height: 230)
                        .foregroundStyle(.white)
                        .opacity(0.5)
                        .shadow(radius: 10)
                    
                    
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 130)
                }
            }
            .padding(.bottom, 140)
            
            HStack {
                Image(systemName: "person")
                    .fontWeight(.semibold)
                    .frame(width: 30)
                
                TextField("Username", text: $username).font(.title3)
                    .shadow(radius: 10)
                
            }
            .foregroundStyle(.white)
            .padding()
            .background(Color.white.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.horizontal, 15)
            .padding(.top, 150)
        }
        .gesture(
            DragGesture(minimumDistance: 100, coordinateSpace: .local)
                .onEnded { value in
                    if value.translation.height > 0 {
                        hideKeyboard()
                    }
                }
        )
    }
}

// MARK: - Preview
#Preview {
    CreateUserScreen(username: "")
}
