import SwiftUI

struct PhoneNumberInputField: View {
    @Binding var selectedCountry: Country
    @Binding var phoneNumber: String
    @State private var showAlert = false
    @State private var navigateToVerify = false
    @StateObject var loginData = OTPViewModel()

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

            Button(action: {
                showAlert = true
            }) {
                Text("Continue")
                    .foregroundStyle(.black)
                    .font(.system(size: 20))
                    .padding(.vertical, 18)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(phoneNumber.count == 10 ? Color.white : Color.white.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .padding(.horizontal, 120)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
                    .disabled(phoneNumber.count != 10)
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

            NavigationLink(value: navigateToVerify) {
                EmptyView()
            }
        }
        .navigationDestination(isPresented: $navigateToVerify) {
            OTPhoneVerifyCode(loginData: loginData)
        }
    }
}

#Preview {
    PhoneNumberInputField(selectedCountry: .constant(Country(name: "Antigua and Barbuda", isoCode: "AG", phoneCode: "+1268")), phoneNumber: .constant(""), loginData: OTPViewModel())
}
