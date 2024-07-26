//
//  AuthCustomField.swift
//  TalkToMe
//
//  Created by Vlad on 26/7/24.
//

import SwiftUI

struct AuthCustomField: View {
    // MARK: - Properties
    var fieldDescription: String
    @State private var text = ""
    @FocusState private var isActive: Bool
    @State private var showPassword = false
    var autocapitalization: TextInputAutocapitalization = .sentences
    
    // MARK: - Body
    var body: some View {
        VStack {
            if fieldDescription == "Password" {
                passwordField()
            } else {
                regularField()
            }
        }
        .padding(.horizontal)
        .padding(.top, 30)
        .background(Color.clear)
    }
    
    // MARK: - Functions
    @ViewBuilder
    private func passwordField() -> some View {
        HStack {
            ZStack(alignment: .leading) {
                SecureField("", text: $text)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55).focused($isActive)
                    .opacity(showPassword ? 0 : 1)
                    .foregroundStyle(.white)
                    .background(Color.white.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .textInputAutocapitalization(autocapitalization)
                
                TextField("", text: $text)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55).focused($isActive)
                    .opacity(showPassword ? 1 : 0)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .textInputAutocapitalization(autocapitalization)
                
                Text(fieldDescription).padding(.leading)
                    .offset(y: (isActive || !text.isEmpty) ? -50 : 0)
                    .animation(.spring, value: isActive)
                    .foregroundStyle(isActive ? .white : .secondary)
                    .onTapGesture {
                        isActive = true
                    }
            }
            .overlay(alignment: .trailing) {
                Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                    .padding(16)
                    .contentShape(Rectangle())
                    .foregroundStyle(showPassword ? .primary : .secondary)
                    .onTapGesture {
                        showPassword.toggle()
                    }
            }
        }
    }
    
    @ViewBuilder
    private func regularField() -> some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text)
                .padding(.leading)
                .frame(maxWidth: .infinity)
                .frame(height: 55).focused($isActive)
                .foregroundStyle(.white)
                .background(.white.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .textInputAutocapitalization(autocapitalization)
            
            Text(fieldDescription).padding(.leading)
                .offset(y: (isActive || !text.isEmpty) ? -50 : 0)
                .animation(.spring, value: isActive)
                .foregroundStyle(isActive ? .white : .secondary)
                .onTapGesture {
                    isActive = true
                }
        }
    }
}

// MARK: - Preview
#Preview {
    AuthCustomField(fieldDescription: "Email")
}
