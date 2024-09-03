import SwiftUI

struct CountryPickerSearchView: View {
    // MARK: - Properties
    @Binding var selectedCountry: CountryPickerViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredCountriesGrouped.keys.sorted(), id: \.self) { letter in
                    Section(header: Text(letter).font(.headline)) {
                        ForEach(filteredCountriesGrouped[letter]!, id: \.isoCode) { country in
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
                }
            }
            .navigationTitle("Search Country")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: LocalizedStringKey("Search Country"))
        }
    }

    // MARK: - Methods
    var filteredCountries: [CountryPickerViewModel] {
        if searchText.isEmpty {
            return CountryPickerViewModel.allCountries
        } else {
            return CountryPickerViewModel.allCountries.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var filteredCountriesGrouped: [String: [CountryPickerViewModel]] {
        Dictionary(grouping: filteredCountries, by: { String($0.name.prefix(1)).uppercased() })
    }
}

#Preview {
    CountryPickerSearchView(selectedCountry: .constant(CountryPickerViewModel.allCountries[0]))
}
