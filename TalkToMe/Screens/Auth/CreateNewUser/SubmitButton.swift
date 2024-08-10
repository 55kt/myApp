import SwiftUI

struct SubmitButton: View {
    @Binding var textPlaceholder: String
    @Binding var boolPlaceholder: Bool
    @Binding var usernameExists: Bool?
    @Binding var showMessage: Bool
    @FocusState.Binding var isFocus: Bool
    @Binding var buttonText: String

    var body: some View {
        VStack {
            Spacer()
            Button {
                checkUsernameAvailability(username: textPlaceholder)
            } label: {
                Text(buttonText)
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .medium))
                    .padding(.vertical, 19)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(isUsernameValid ? Color.yellow : Color.yellow.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
                    .scaleEffect(isUsernameValid ? 1.0 : 0.95) // Changing the scale of a button when entering text in the UsernameField
            }
            .disabled(!isUsernameValid)
            .frame(height: 100)
            .padding(.top, boolPlaceholder ? 0 : 300)
            .animation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5), value: textPlaceholder)
        }
        .onChange(of: isFocus) {oldValue, newValue in
                    withAnimation(.easeInOut(duration: 0.2)) { // Animation of changing button text
                        buttonText = newValue ? "Submit User Nickname" : "Create New User"
                    }
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
    
    private var isUsernameValid: Bool {
        return !textPlaceholder.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private func checkUsernameAvailability(username: String) {
        let existingUsernames = ["testuser", "example", "username"] // Example of existing nicknames to check the message about an existing nickname
        showMessage = false
        withAnimation {
            usernameExists = existingUsernames.contains(username.lowercased())
            showMessage = true // Показываем сообщение
        }
        
        if let usernameExists = usernameExists {
            if usernameExists {
                showMessage = true
            } else {
                isFocus = false
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showMessage = false
                print("Message should start disappearing")
            }
        }
    }
}
