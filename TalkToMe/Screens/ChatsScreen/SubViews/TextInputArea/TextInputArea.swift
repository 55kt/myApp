import SwiftUI

struct TextInputArea: View {
    
    // MARK: - Properties
    @Binding var textMessage: String
    let onSendHandler: () -> ()
    
    private var disableSendButton: Bool {
        return textMessage.isEmptyOrWhitespace
    }
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .bottom, spacing: 5) {
            imagePickerButton()
                .padding(3)
            audioRecorderButton()
            messageTextField(text: $textMessage)
            sendMessageButton() {
                onSendHandler()
            }
                .disabled(disableSendButton)
                .grayscale(disableSendButton ? 0.8 : 0)
        }
        .padding(.bottom)
        .padding(.horizontal, 8)
        .padding(.top, 10)
        .background(.white)
    }
}

// MARK: - Preview
#Preview {
    TextInputArea(textMessage: .constant("")) {}
}
