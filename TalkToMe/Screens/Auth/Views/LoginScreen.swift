//
//  LoginScreen.swift
//  TalkToMe
//
//  Created by Vlad on 25/7/24.
//

import SwiftUI

struct LoginScreen: View {
    
    // MARK: - Body
    var body: some View {
        VStack {
            AuthCustomField(fieldDescription: "Email")
            AuthCustomField(fieldDescription: "Password")
            
            Text("Login Screen")
                .bold()
                .font(.system(size: 70))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.blacksky)
                .resizable()
                .scaledToFill()
        
        )
        
                .ignoresSafeArea()
    }
}

// MARK: - Preview
#Preview {
    LoginScreen()
}
