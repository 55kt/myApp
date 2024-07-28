//
//  OTPVerificationScreen.swift
//  TalkToMe
//
//  Created by Vlad on 28/7/24.
//

import SwiftUI

struct OTPVerificationScreen: View {
    // MARK: - Properties
    @StateObject var loginData: OTPLoginViewModel
    @Environment(\.presentationMode) var present
    
    // MARK: - Body
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button {
                        present.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                    
                    Text("Verify your phone number")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding()
                
                Text("Code sent to \(loginData.phoneNumber)")
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                Spacer(minLength: 0)
                
                HStack(spacing: 15) {
                    ForEach(0..<6, id: \.self) { index in
                        CodeView(code: getCodeAtIndex(index: index))
                    }
                }
                .padding()
                .padding(.horizontal, 20)
                
                Spacer(minLength: 0)
                
                HStack(spacing: 6) {
                    Text("Didn`t recieve code?")
                        .foregroundStyle(.gray)
                    
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
                
                Button {
                    // Some action
                } label: {
                    Text("Verify and Create Account")
                        .foregroundStyle(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(.yellow)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding()
            }
            .frame(height: UIScreen.main.bounds.height / 1.8)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
            CustomNumberPad(value: $loginData.code, isVerify: true)
        }
        .background(Color(.gray).opacity(0.1).ignoresSafeArea(.all, edges: .bottom))
        .toolbar(.hidden)
        .navigationBarBackButtonHidden(true)
    }
    
    func getCodeAtIndex(index: Int) -> String {
        if loginData.code.count > index {
            let start = loginData.code.startIndex
            let current = loginData.code.index(start, offsetBy: index)
            return String(loginData.code[current])
        }
        return ""
    }
}

struct CodeView: View {
    // MARK: - Properties
    var code: String
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 10) {
            Text(code)
                .foregroundStyle(.black)
                .fontWeight(.bold)
                .font(.title2)
            
                .frame(height: 45)
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 4)
        }
    }
}

//// MARK: - Preview
//#Preview {
//    OTPVerificationScreen()
//}
