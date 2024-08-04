//
//  ConfirmationSheet.swift
//  TalkToMe
//
//  Created by Vlad on 3/8/24.
//

import SwiftUI

struct ConfirmationSheet: View {
    @Binding var selectedCountry: Country
    @Binding var phoneNumber: String
    @StateObject var loginData: OTPViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("\(selectedCountry.phoneCode) \(phoneNumber)")
                .font(.largeTitle)
                .padding()
            
            Text("Is this the correct number?")
                .padding()
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Edit")
                        .font(.title2)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                NavigationLink(destination: OTPhoneVerifyCode(loginData: loginData)
                    .onAppear {
                        loginData.phoneNumber = "\(selectedCountry.phoneCode) \(phoneNumber)"
                    }
                ) {
                    Text("Continue")
                        .font(.title2)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .padding(.top)
        }
        .presentationDetents([.medium, .large])
        .background(Color.white)
        .cornerRadius(20)
        .padding()
    }
}
