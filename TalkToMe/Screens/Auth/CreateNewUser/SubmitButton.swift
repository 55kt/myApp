import SwiftUI

struct SubmitButton: View {
    @Binding var textPlaceholder: String 
    @Binding var boolPlaceholder: Bool
    
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                print("Button tapped!")
            } label: {
                Text("Submit")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .medium))
                    .padding(.vertical, 18)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(textPlaceholder.count >= 5 ? Color.yellow : Color.yellow.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
            }
            .disabled(textPlaceholder.isEmpty || textPlaceholder.count != 15)
            .frame(height: 100)
            .padding(.top, boolPlaceholder ? 0 : 300)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            withAnimation {
                boolPlaceholder = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            withAnimation {
                boolPlaceholder = false
            }
        }
        .padding()
    }
}
