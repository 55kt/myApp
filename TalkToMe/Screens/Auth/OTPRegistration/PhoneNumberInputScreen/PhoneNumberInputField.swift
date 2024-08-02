//
//  PhoneNumberInputField.swift
//  TalkToMe
//
//  Created by Vlad on 2/8/24.
//

import SwiftUI

struct PhoneNumberInputField: View {
    @State private var selectedCountry: Country = Country(name: "Antigua and Barbuda", isoCode: "AG", phoneCode: "+1268")
    @State private var phoneNumber: String = ""
    @StateObject var loginData = OTPViewModel()

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.white.opacity(0.3))
                    .frame(height: 60) // Задайте фиксированную высоту для заднего фона
                
                HStack(spacing: 0) {
                    // Country Phone isoCode
                    Text(selectedCountry.isoCode)
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .bold()
                        .padding(.leading, 20)
                        .padding(.trailing, -11)
                    // Country Phone Code
                    Text(selectedCountry.phoneCode)
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .bold()
                        .frame(width: 107) // Устанавливаем фиксированную ширину
                    
                    // Phone NumberField
                    TextField("000 000 0000", text: $phoneNumber)
                        .font(.system(size: 25))
                        .foregroundStyle(.white)
                        .keyboardType(.numberPad)
                        .padding()
                }
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
            }
            .padding(.horizontal)
            NavigationLink(destination: OTPhoneVerifyCode(loginData: loginData)) {
                Text("Continue")
                    .foregroundStyle(.black)
                    .font(.system(size: 20))
                    .padding(.vertical, 18)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(phoneNumber.count == 10 ? Color.white : Color.white.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .padding(.horizontal, 120)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
                    .disabled(loginData.phoneNumber == "" ? true : false)
            }
            .frame(height: 44)
            .background(Color.clear)
            .padding(.top, 20)
        }
    }
}

#Preview {
    PhoneNumberInputField()
}
