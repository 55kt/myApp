import SwiftUI

extension TextInputArea {
    
    // MARK: - Functions
    
    // Message text field
    internal func messageTextField(text: Binding<String>) -> some View {
        TextField("", text: text, axis: .vertical)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(.thinMaterial))
            .overlay(
                textViewBorder()
            )
    }
    
    // Border for text view
    private func textViewBorder() -> some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .stroke(Color(.systemGray5), lineWidth: 1)
    }
    
    // Image picker button
    internal func imagePickerButton() -> some View {
        Button {
            // Some action
        } label: {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 22))
        }
    }
    
    // Audio recorder button
    internal func audioRecorderButton() -> some View {
        Button {
            // Some action
        } label: {
            Image(systemName: "mic.fill")
                .fontWeight(.heavy)
                .imageScale(.small)
                .foregroundStyle(.white)
                .padding(6)
                .background(.blue)
                .clipShape(Circle())
        }
    }
    
    // Send message button
    internal func sendMessageButton() -> some View {
        Button {
            // Some action
        } label: {
            Image(systemName: "arrow.up")
                .fontWeight(.heavy)
                .foregroundStyle(.white)
                .padding(6)
                .background(.blue)
                .clipShape(Circle())
        }
    }
}
