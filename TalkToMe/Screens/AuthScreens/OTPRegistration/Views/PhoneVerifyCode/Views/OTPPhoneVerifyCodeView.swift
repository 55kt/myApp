import SwiftUI

struct OTPPhoneVerifyCodeView: View {
    // MARK: - Properties
    @FocusState private var focusedField: Int?
    @State private var codeFields = ["", "", "", "", "", ""]
    
    @ObservedObject var loginData: OTPViewModel
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                IntroGradient()
                OpacityBackgroundLogo()
                VStack {
                    VStack {
                        
                        /// NavBar Text & Phone number view
                        NavBarElements(phoneNumberPlaceholder: loginData.phoneNumber)
                        
                        Spacer(minLength: 0)
                        
                        
                        /// Code Platform input
                        HStack(spacing: 15) {
                            ForEach(0..<6, id: \.self) { index in
                                CodeInputPlatforms(codeFields: $codeFields, focusedField: $focusedField, index: index)
                            }
                        }
                        .padding()
                        .padding(.horizontal, 20)
                        
                        TimerView(
                                                    onTimerEnd: {
                                                        print("Timer ended")
                                                    },
                                                    onResendCode: {
                                                        print("Code resent")
                                                    }
                                                )
                                                .padding(.top, 20)
                        
                        Spacer(minLength: 0)
                        
                        /// Support Area
//                        SupportArea()
                        
                        /// Verify Button
                        VerifyButton(boolPlaceholder: allFieldsFilled())
                            .disabled(!allFieldsFilled())
                    }
                    .background(Color(.clear))
                }
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
                .toolbar(.hidden)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    // MARK: - Functions
    func allFieldsFilled() -> Bool {
        return !codeFields.contains { $0.isEmpty }
    }
}

//// MARK: - Preview
#Preview {
    OTPPhoneVerifyCodeView(loginData: OTPViewModel())
}
