//
//  CountryPickerView.swift
//  TalkToMe
//
//  Created by Vlad on 1/8/24.
//

import SwiftUI

struct CountryPickerView: View {
    @Binding var selectedCountry: Country
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredCountries, id: \.isoCode) { country in
                    HStack {
                        Text(country.flag)
                        Text(country.name)
                        Spacer()
                        Text(country.phoneCode)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedCountry = country
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Select Country")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: LocalizedStringKey("Look for something"))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isSearchFocused = true
                }
        }
        
        }
        
        var filteredCountries: [Country] {
            if searchText.isEmpty {
                return Country.allCountries
            } else {
                return Country.allCountries.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
    }
}
