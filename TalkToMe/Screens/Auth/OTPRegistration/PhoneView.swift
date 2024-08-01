//
//  PhoneView.swift
//  TalkToMe
//
//  Created by Vlad on 1/8/24.
//

import SwiftUI

struct PhoneInputView: View {
    @State private var selectedCountry: Country = Country(name: "Greece", isoCode: "GR", phoneCode: "+30")
    @State private var phoneNumber: String = ""
    @State private var isCountryPickerPresented: Bool = true
    @State private var isConfirmPresented: Bool = false
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "phone.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding()

                Text("Your Phone")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Text("Please confirm your country code and enter your phone number.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()

                Button(action: {
                    isCountryPickerPresented.toggle()
                }) {
                    HStack {
                        Text("\(selectedCountry.flag) \(selectedCountry.name)")
                            .foregroundColor(.blue)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                .sheet(isPresented: $isCountryPickerPresented) {
                    CountryPickerView(selectedCountry: $selectedCountry)
                }

                HStack(spacing: 0) {
                    Text(selectedCountry.phoneCode)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10, corners: [.topLeft, .bottomLeft])

                    TextField("000 000 0000", text: $phoneNumber)
                        .padding()
                        .keyboardType(.numberPad)
                        .background(Color(.systemGray6))
                        .cornerRadius(10, corners: [.topRight, .bottomRight])
                }
                .padding(.horizontal)
                .padding(.top)

                Button(action: {
                    isConfirmPresented.toggle()
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(phoneNumber.count == 10 ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(phoneNumber.count != 10)
                .padding()
                .alert(isPresented: $isConfirmPresented) {
                    Alert(
                        title: Text("Confirm Phone Number"),
                        message: Text("\(selectedCountry.phoneCode) \(phoneNumber)\nIs this the correct number?"),
                        primaryButton: .default(Text("Continue")),
                        secondaryButton: .cancel(Text("Edit"))
                    )
                }
            }
            .navigationTitle("Phone Input")
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct PhoneInputView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneInputView()
    }
}

#Preview {
    PhoneInputView()
}
