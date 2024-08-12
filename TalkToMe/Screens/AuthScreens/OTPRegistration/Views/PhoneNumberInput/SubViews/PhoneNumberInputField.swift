import SwiftUI

struct PhoneNumberInputField: View {
    // MARK: - Properties
    @Binding var selectedCountry: Country
    @Binding var phoneNumber: String
    @State private var navigateToVerify = false
    @StateObject var loginData = OTPViewModel()

    // MARK: - Body
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.white.opacity(0.3))
                    .frame(height: 60)

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
                        .frame(width: 107)

                    // Phone NumberField
                    TextField("000 000 0000", text: $phoneNumber)
                        .keyboardType(.numberPad)
                        .font(.system(size: 25))
                        .foregroundStyle(.white)
                        .padding()
                }
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .padding(.horizontal)

//            PhoneInputButton(phoneNumber: $phoneNumber, selectedCountry: $selectedCountry)
//                .disabled(phoneNumber.count < 10)


        }
//        .navigationDestination(isPresented: $navigateToVerify) {
//            OTPhoneVerifyCode(loginData: loginData)
//        }
    }
}

