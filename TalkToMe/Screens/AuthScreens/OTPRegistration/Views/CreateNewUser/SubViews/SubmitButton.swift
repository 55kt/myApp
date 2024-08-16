import SwiftUI

struct SubmitButton: View {
    
    // MARK: - Properties
    @Binding var textPlaceholder: String
    @Binding var boolPlaceholder: Bool
    @Binding var usernameExists: Bool?
    @Binding var showMessage: Bool
    @FocusState.Binding var isFocus: Bool
    @Binding var buttonText: String
    @Binding var showFinalScreen: Bool // Для управления переходом на финальный экран
    @Binding var errorMessage: String? // Сообщение об ошибке

    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                validateAndProceed() // Проверка перед переходом или сброс в исходное состояние
            } label: {
                Text(buttonText)
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .medium))
                    .padding(.vertical, 19)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(isUsernameValid ? Color.yellow : Color.yellow.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
                    .scaleEffect(isUsernameValid ? 1.0 : 0.95)
            }
            .disabled(!isUsernameValid)
            .frame(height: 100)
            .padding(.top, boolPlaceholder ? 0 : 300)
            .animation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5), value: textPlaceholder)
        }
        .onChange(of: isFocus) { oldValue, newValue in
            withAnimation(.easeInOut(duration: 0.2)) {
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
    
    private func validateAndProceed() {
        if textPlaceholder.isEmpty {
            errorMessage = "Please enter some nickname"
            showMessageWithHideDelay()
        } else if buttonText == "Create New User" {
            // Если текст кнопки "Create New User" и поле заполнено, переходим на финальный экран
            showMessage = false
            showFinalScreen = true
        } else if buttonText == "Submit User Nickname" {
            // Если текст кнопки "Submit User Nickname", проверяем существование никнейма
            checkUsernameAvailability(username: textPlaceholder)
        }
    }
    
    private func checkUsernameAvailability(username: String) {
        let existingUsernames = ["testuser", "example", "username"]
        showMessage = false
        
        withAnimation {
            usernameExists = existingUsernames.contains(username.lowercased())
            if usernameExists == true {
                showMessageWithHideDelay()
                errorMessage = "Username already exists."
            } else {
                // Никнейм не существует, возвращаем кнопку в исходное состояние
                resetButtonState()
            }
        }
    }
    
    private func showMessageWithHideDelay() {
        showMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showMessage = false
            }
        }
    }
    
    private func resetButtonState() {
        withAnimation {
            isFocus = false
            buttonText = "Create New User"
        }
    }
}
