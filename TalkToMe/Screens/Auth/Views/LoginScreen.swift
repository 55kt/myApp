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
            Text("Login Screen")
                .bold()
                .font(.system(size: 70))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .ignoresSafeArea()
    }
}

// MARK: - Preview
#Preview {
    LoginScreen()
}
