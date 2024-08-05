//
//  CustomButton.swift
//  TalkToMe
//
//  Created by Vlad on 4/8/24.
//

import SwiftUI

struct  PhoneInputButton: View {
    // MARK: - Properties
    @Binding var phoneNumber: String
    @Binding var selectedCountry: Country
    @State private var showAlert = false
    @State private var navigateToVerify = false
    
    @StateObject var loginData = OTPViewModel()
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            showAlert = true
        }) {
            Text("Continue")
                .foregroundStyle(.black)
                .font(.system(size: 20))
                .padding(.vertical, 18)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(phoneNumber.count >= 10 ? Color.yellow : Color.yellow.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .padding(.horizontal, 16)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
                
        }
        .frame(height: 44)
        .background(Color.clear)
        .padding(.top, 5)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Confirm Number"),
                message: Text("Is this the correct number?\n\(selectedCountry.phoneCode) \(phoneNumber)"),
                primaryButton: .default(Text("Continue"), action: {
                    // Update loginData.phoneNumber and navigate
                    loginData.phoneNumber = "\(selectedCountry.phoneCode) \(phoneNumber)"
                    navigateToVerify = true
                }),
                secondaryButton: .cancel(Text("Edit"))
            )
        }
        .navigationDestination(isPresented: $navigateToVerify) {
            OTPhoneVerifyCode(loginData: loginData)
        }
    }
}
