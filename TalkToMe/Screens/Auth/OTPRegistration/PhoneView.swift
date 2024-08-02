//
//  PhoneView.swift
//  TalkToMe
//
//  Created by Vlad on 1/8/24.
//

import SwiftUI

struct PhoneInputView: View {
    @State private var selectedCountry: Country = Country(name: "Greece", isoCode: "GR", phoneCode: "+30")
    @State private var phoneNumber: String = ""
    @State private var isCountryPickerPresented: Bool = false
    @State private var isConfirmPresented: Bool = false
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "phone.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding()
                
                Text("Your Phone")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Please confirm your country code and enter your phone number.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                
                // Country Area
                Button(action: {
                    isCountryPickerPresented.toggle()
                }) {
                    HStack {
                        Text("\(selectedCountry.flag) \(selectedCountry.name)")
                            .foregroundColor(.black)
                            .frame(width: 307)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background()
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .padding(.horizontal)
                .sheet(isPresented: $isCountryPickerPresented) {
                    CountryPickerView(selectedCountry: $selectedCountry)
                }
                
                // Border Line
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .padding(.horizontal)
                    .padding(.vertical, -15)
                
                // Phone Number Field
                HStack(spacing: 0) {
                    Text(selectedCountry.phoneCode)
                        .padding()
                        .background(Color(.systemGray6))
                    
                    TextField("000 000 0000", text: $phoneNumber)
                        .padding()
                        .keyboardType(.numberPad)
                        .background(Color(.systemGray6))
                }
                .padding(.horizontal)
                .frame(height: 25)
                
                // Continue Button
                Button(action: {
                    isConfirmPresented.toggle()
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(phoneNumber.count == 10 ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(phoneNumber.count != 10)
                .padding()
                .alert(isPresented: $isConfirmPresented) {
                    Alert(
                        title: Text("Confirm Phone Number"),
                        message: Text("\(selectedCountry.phoneCode) \(phoneNumber)\nIs this the correct number?"),
                        primaryButton: .default(Text("Continue")),
                        secondaryButton: .cancel(Text("Edit"))
                    )
                }
            }
        }
    }
}

#Preview {
    PhoneInputView()
}
