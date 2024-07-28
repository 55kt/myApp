//
//  OTPLoginScreen.swift
//  TalkToMe
//
//  Created by Vlad on 27/7/24.
//

import SwiftUI

struct OTPLoginScreen: View {
    // MARK: - Properties
    @StateObject var loginData = OTPLoginViewModel()
    
    // MARK: - Body
    var body: some View {
        
        VStack {
            
            VStack {
                Text("Continue with your phone number")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .padding()
                
                Image(.otpicon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                Text("You`ll receive a 6 digit code\n to verify next")
                    .font(.title2)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                
                // Mobile Number Field...
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Enter your number")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        Text("+ \(loginData.getCountryCode())  \(loginData.phoneNumber)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
                    
                    Spacer(minLength: 0)
                    
                    NavigationLink(destination: OTPVerificationScreen(loginData: loginData)) {
                        
                        Text("Continue")
                            .foregroundStyle(.black)
                            .padding(.vertical, 18)
                            .padding(.horizontal, 38)
                            .background(.yellow)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    .disabled(loginData.phoneNumber == "" ? true : false)
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
            }
            .frame(height: UIScreen.main.bounds.height / 2.1)
            .background(.white)
            
            CustomNumberPad(value: $loginData.phoneNumber, isVerify: false)
        }
        .background(Color(.gray).opacity(0.1).ignoresSafeArea(.all, edges: .bottom))
    }
}

#Preview {
    NavigationStack {
        OTPLoginScreen()
    }
}
