//
//  CountryPicker.swift
//  TalkToMe
//
//  Created by Vlad on 2/8/24.
//

import SwiftUI

struct CountryPicker: View {
    // MARK: - Properties
    @Binding var selectedCountry: Country
    @State private var isCountryPickerPresented: Bool = false

    // MARK: - Body
    var body: some View {
        Button(action: {
            isCountryPickerPresented.toggle()
        }) {
            HStack {
                Text("\(selectedCountry.flag) \(selectedCountry.name)")
                    .font(.system(size: 25))
                
                    .foregroundColor(.white)
                    .frame(width: 307)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
            }
            .padding()
            .background(Color(.clear))
        }
        .padding(.horizontal)
        .sheet(isPresented: $isCountryPickerPresented) {
            CountryPickerView(selectedCountry: $selectedCountry)
        }
        // Border Line
        Rectangle()
            .foregroundColor(.white)
            .frame(height: 2)
            .opacity(0.6)
            .padding(.horizontal)
            .padding(.vertical, -15)
    }
}

// MARK: - Preview
#Preview {
    CountryPicker(selectedCountry: .constant(Country(name: "Antigua and Barbuda", isoCode: "AG", phoneCode: "+1268")))
}
