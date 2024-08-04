import SwiftUI

struct OTPhoneVerifyCode: View {
    // MARK: - Properties
    @StateObject var loginData: OTPViewModel
    @Environment(\.presentationMode) var present
    @FocusState private var focusedField: Int?
    @State private var codeFields = ["", "", "", "", "", ""]

    // MARK: - Body
    var body: some View {
        ZStack {
            IntroGradient()
            VStack {
                VStack {
                    
                    /// NavBar Group
                    Group {
                        HStack {
                            Button {
                                present.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "arrow.left")
                                    .bold()
                                    .font(.title2)
                                    .foregroundStyle(.white)
                            }
                            
                            Spacer()
                            
                            Text("Verify your phone number")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            
                            
                            Spacer()
                        }
                        .padding()
                        
                        Text("Code sent to \(loginData.phoneNumber)")
                            .foregroundStyle(.white)
                            .padding(.bottom)
                    }
                    
                    Spacer(minLength: 0)
                    
                    /// Code Platform input
                    HStack(spacing: 15) {
                        ForEach(0..<6, id: \.self) { index in
                            CodeInputView(index: index)
                        }
                    }
                    .padding()
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 0)
                    
                    /// Support Area
                    HStack(spacing: 6) {
                        Text("Didn't receive code?")
                            .foregroundStyle(.white)
                        
                        Button {
                            // Some action
                        } label: {
                            Text("Request again")
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                        }
                        
                        
                    }

                    Button {
                        // Some action
                    } label: {
                        Text("Get via call")
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
                    .padding(.top, 6)
                    
                    
                    /// Verify Button
                    Button {
                        // Some action
                    } label: {
                        Text("Verify and Create Account")
                            .foregroundStyle(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(allFieldsFilled() ? Color.yellow : Color.white.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    .padding()
                    .disabled(!allFieldsFilled())
                }
//                .frame(height: UIScreen.main.bounds.height / 1.8)
                .background(Color(.clear))
                
//                CustomNumberPad(value: $loginData.code, isVerify: true)
            }
            .toolbar(.hidden)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    focusedField = 0
                }
            }
        }
    }
    
    // MARK: - Functions
    func allFieldsFilled() -> Bool {
        return !codeFields.contains { $0.isEmpty }
    }
    
    // MARK: - CodeInputView
    @ViewBuilder
    func CodeInputView(index: Int) -> some View {
        TextField("", text: $codeFields[index])
            .foregroundStyle(.white)
            .fontWeight(.bold)
            .font(.title2)
            .frame(width: 45, height: 45)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .focused($focusedField, equals: index)
            .background(
                Capsule()
                    .fill(Color.white.opacity(0.8))
                    .frame(height: 4)
                    .offset(y: 20)
            )
            .onChange(of: codeFields[index]) {oldValue, newValue in
                if newValue.count > 1 {
                    codeFields[index] = String(newValue.prefix(1))
                }
                if newValue.count == 1 {
                    if index < 5 {
                        focusedField = index + 1
                    } else {
                        focusedField = nil
                    }
                }
            }
            .onTapGesture {
                focusedField = index
            }
    }
}

//// MARK: - Preview
#Preview {
    OTPhoneVerifyCode(loginData: OTPViewModel())
}