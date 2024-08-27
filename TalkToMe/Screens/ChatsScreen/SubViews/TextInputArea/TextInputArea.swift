import SwiftUI

struct TextInputArea: View {
    
    // MARK: - Properties
    @State private var text = ""
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .bottom, spacing: 5) {
            imagePickerButton()
                .padding(3)
            audioRecorderButton()
            messageTextField(text: $text)
            sendMessageButton()
        }
        .padding(.bottom)
        .padding(.horizontal, 8)
        .padding(.top, 10)
        .background(.white)
    }
}

// MARK: - Preview
#Preview {
    TextInputArea()
}
