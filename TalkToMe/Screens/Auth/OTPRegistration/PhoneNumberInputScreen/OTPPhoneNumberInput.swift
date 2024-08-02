//
//  OTPLoginScreen.swift
//  TalkToMe
//
//  Created by Vlad on 27/7/24.
//

import SwiftUI

struct OTPPhoneNumberInput: View {
    // MARK: - Properties
    @State private var selectedCountry: Country = Country(name: "Antigua and Barbuda", isoCode: "AG", phoneCode: "+1268")
    @State private var isCountryPickerPresented: Bool = false
    @State private var phoneNumber: String = ""


    @StateObject var loginData = OTPViewModel()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            IntroGradient()
            VStack {
                // Nav Bar & center screen elements
                NavPlaceHolder()
                
                // Country Area
                CountryPicker()
                
                // Phone Number Field
                PhoneNumberInputField()
                
                }
            .ignoresSafeArea(.keyboard, edges: .bottom)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
                .padding(.bottom, 250)
//                CustomNumberPad(value: $loginData.phoneNumber, isVerify: false)
            }
        }
    }

#Preview {
    NavigationStack {
        OTPPhoneNumberInput()
    }
}






