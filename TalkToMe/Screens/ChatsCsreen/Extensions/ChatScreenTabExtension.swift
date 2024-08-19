import SwiftUI

extension ChatsTabView {
    
    // MARK: - Functions
    
    // Toolbar button for leading items
    @ToolbarContentBuilder
    internal func leadingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                Button {
                    // Some action
                } label: {
                    Label("Select Chats", systemImage: "checkmark.circle")
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
        }
    }
    
    // Toolbar buttons? for trailing items
    @ToolbarContentBuilder
    internal func trailingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            cameraButton()
        }
    }
    
    // Toolbar button for camera
    private func cameraButton() -> some View {
        Button {
            // Some action
        } label: {
            Image(systemName: "camera")
        }
    }
    
    // Toolbar button for arcived chats
    internal func arcivedButton() -> some View {
        Button {
            // Some action
        } label: {
            Label("Arcived Chats", systemImage: "archivebox.fill")
                .bold()
                .padding()
                .foregroundStyle(.green)
        }
    }
    
    // Bottom Description text view function
    internal func inboxFooterView() -> some View {
        HStack {
            Image(systemName: "lock.fill")
            
            (
                Text("Your personal messages are ")
                +
                Text("end-to-end encrypted")
                    .foregroundStyle(.blue)
            )
        }
        .foregroundStyle(.gray)
        .font(.caption)
        .padding(.horizontal)
    }
}
