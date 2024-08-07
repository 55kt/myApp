import SwiftUI

struct CodeInputPlatforms: View {
    @Binding var codeFields: [String]
    @FocusState.Binding var focusedField: Int?
    var index: Int
    
    var body: some View {
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
            .onChange(of: codeFields[index]) { oldValue, newValue in
                if newValue.count > 1 {
                    codeFields[index] = String(newValue.prefix(1))
                }
                if newValue.isEmpty {
                    if index > 0 {
                        focusedField = index - 1
                    }
                } else if newValue.count == 1 {
                    if index < 5 {
                        focusedField = index + 1
                    } else {
                        focusedField = index
                    }
                }
            }
            .onTapGesture {
                focusedField = index
            }
    }
}
