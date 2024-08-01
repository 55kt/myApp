//
//  OTPLoginScreen.swift
//  TalkToMe
//
//  Created by Vlad on 27/7/24.
//

import SwiftUI

struct OTPhoneInput: View {
    // MARK: - Properties
    @StateObject var loginData = OTPViewModel()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            IntroGradient()
            VStack {
                
                VStack {
                    VStack {
                        Text("Continue with your phone number")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding()
                        
                        Image(systemName: "platter.filled.top.and.arrow.up.iphone")
                            .resizable()
                            .frame(width: 100, height: 160)
                            .foregroundStyle(.white)
                            
                        
                        Text("You`ll receive a 6 digit code\n to verify next")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .shadow(radius: 10)
                    
                    // Mobile Number Field...
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Enter your number")
                                .font(.callout)
                                .foregroundStyle(.white)
                            
                            Text("+ \(loginData.getCountryCode())  \(loginData.phoneNumber)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                        
                        Spacer(minLength: 0)
                        
                        NavigationLink(destination: OTPhoneVerifyCode(loginData: loginData)) {
                            
                            Text("Continue")
                                .foregroundStyle(.black)
                                .padding(.vertical, 18)
                                .padding(.horizontal, 38)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        }
                        .disabled(loginData.phoneNumber == "" ? true : false)
                    }
                    .padding()
                    .background(Color(.clear))
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                }
                .frame(height: UIScreen.main.bounds.height / 2.1)
                .background(Color(.clear))
                
                CustomNumberPad(value: $loginData.phoneNumber, isVerify: false)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    NavigationStack {
        OTPhoneInput()
    }
}
