import SwiftUI

struct CountryPickerView: View {
    // MARK: - Properties
    @Binding var selectedCountry: CountryPickerViewModel
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
            CountryPickerSearchView(selectedCountry: $selectedCountry)
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

#Preview {
    CountryPickerView(selectedCountry: .constant(CountryPickerViewModel.allCountries[0]))
}
