//
//  PhoneView.swift
//  TalkToMe
//
//  Created by Vlad on 1/8/24.
//

import SwiftUI
import Combine
import CountryPicker

// CountryPickerRepresentable для SwiftUI
struct CountryPickerRepresentable: UIViewControllerRepresentable {
    @Binding var selectedCountry: Country

    func makeUIViewController(context: Context) -> CountryPickerViewController {
        let countryPicker = CountryPickerViewController()
        countryPicker.selectedCountry = selectedCountry.isoCode
        countryPicker.delegate = context.coordinator
        return countryPicker
    }

    func updateUIViewController(_ uiViewController: CountryPickerViewController, context: Context) {
        // Здесь можно обновлять uiViewController, если нужно
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, CountryPickerDelegate {
        var parent: CountryPickerRepresentable

        init(_ parent: CountryPickerRepresentable) {
            self.parent = parent
        }

        func countryPicker(didSelect country: Country) {
            parent.selectedCountry = country
        }
    }
}

// Custom Corner Radius Modifier
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct PhoneInputView: View {
    @State private var selectedCountry: Country = Country(isoCode: "GR")
    @State private var phoneNumber: String = ""
    @State private var isCountryPickerPresented: Bool = false
    @State private var isConfirmPresented: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "phone.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.top, 50)

                Text("Your Phone")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                Text("Please confirm your country code and enter your phone number.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.top, 10)

                Button(action: {
                                    isCountryPickerPresented.toggle()
                                }) {
                                    HStack {
                                        Text(flag(from: selectedCountry.isoCode))
                                            .font(.largeTitle)
                                        Text(selectedCountry.localizedName)
                                            .foregroundColor(.blue)
                                        Spacer()
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(.blue)
                                    }
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                }
                                .padding(.horizontal, 40)
                                .padding(.top, 20)
                                .sheet(isPresented: $isCountryPickerPresented) {
                                    CountryPickerRepresentable(selectedCountry: $selectedCountry)
                                }

                HStack(spacing: 0) {
                    Text(selectedCountry.phoneCode)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8, corners: [.topLeft, .bottomLeft])
                    TextField("000 000 0000", text: $phoneNumber)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8, corners: [.topRight, .bottomRight])
                        .onReceive(Just(phoneNumber)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.phoneNumber = filtered
                            }
                        }
                }
                .padding(.horizontal, 40)
                .padding(.top, 10)

                Spacer()

                Button(action: {
                    isConfirmPresented = true
                }) {
                    Text("Continue")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(phoneNumber.count == 10 ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 40)
                }
                .disabled(phoneNumber.count != 10)
                .padding(.bottom, 50)
                .alert(isPresented: $isConfirmPresented) {
                    Alert(
                        title: Text("\(selectedCountry.phoneCode) \(phoneNumber)"),
                        message: Text("Is this the correct number?"),
                        primaryButton: .default(Text("Continue")),
                        secondaryButton: .cancel(Text("Edit"))
                    )
                }
            }
            .navigationBarHidden(true)
        }
    }
    func flag(from countryCode: String) -> String {
            let base: UInt32 = 127397
            var s = ""
            for v in countryCode.uppercased().unicodeScalars {
                s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
            }
            return String(s)
        }
}

#Preview {
    PhoneInputView()
}
