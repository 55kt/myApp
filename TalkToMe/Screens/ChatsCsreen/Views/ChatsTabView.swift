import SwiftUI

struct ChatsTabView: View {
    // MARK: - Properties
    @State private var searchText = ""
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                arcivedButton()
                
                ForEach(0..<12) { _ in
                    NavigationLink {
                        ChatRoomView()
                    } label: {
                        ChatScreenRow()
                    }
                }
                inboxFooterView()
                    .listRowSeparator(.hidden)
            }
            .navigationTitle("Chats")
            .background{
                GrayGradient()
                    .ignoresSafeArea()
            }
            .searchable(text: $searchText)
            .listStyle(.plain)
            .toolbar {
                leadingNavItems()
                trailingNavItems()
            }
        }
    }
    
    // MARK: - Methods
    // Toolbar button for leading items
    @ToolbarContentBuilder
    private func leadingNavItems() -> some ToolbarContent {
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
    private func trailingNavItems() -> some ToolbarContent {
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
    private func arcivedButton() -> some View {
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
    private func inboxFooterView() -> some View {
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

// MARK: - Preview
#Preview {
    NavigationStack {
        ChatsTabView()
    }
}
