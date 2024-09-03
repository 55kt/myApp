import SwiftUI

struct OTPPhoneNumberInputView: View {
    // MARK: - Properties
    @State private var selectedCountry: CountryPickerViewModel = CountryPickerViewModel(name: "Antigua and Barbuda", isoCode: "AG", phoneCode: "+1268")
    @State private var phoneNumber: String = ""
    @FocusState private var isFocus: Bool
    
    @StateObject var loginData = OTPViewModel()
    
        
    // MARK: - Body
    var body: some View {
        ZStack {
            IntroGradient()
            ScrollView {
                VStack {
                    // Nav Bar & center screen elements
                    NavPlaceHolder()
                    
                    // Country Area
                    CountryPickerView(selectedCountry: $selectedCountry)
                    
                    // Phone Number Field
                    PhoneNumberInputField(selectedCountry: $selectedCountry, phoneNumber: $phoneNumber, loginData: loginData)
//                        .focused($isFocus)
                    
                    // Continue Button
                    ContinueButton(phoneNumber: $phoneNumber, selectedCountry: $selectedCountry, loginData: loginData)
                }
                .padding(.bottom, 250)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
                .navigationBarBackButtonHidden(true)
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    NavigationStack {
        OTPPhoneNumberInputView()
    }
}

/// ScrollView was added so that when the numpad appears, it will overlap all the elements on top without moving them.
///
///
///
///
///
///






