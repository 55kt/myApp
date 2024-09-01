import SwiftUI

struct ChatsTabView: View {
    // MARK: - Properties
    @State private var searchText = ""
    @StateObject private var viewModel = ChatTabViewModel()
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                arcivedButton()
                
                ForEach(viewModel.channels) { channel in
                    NavigationLink {
                        ChatRoomView(channel: channel)
                    } label: {
                        ChatScreenRow(channel: channel)
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
            .sheet(isPresented: $viewModel.showChatPartnerPicker) {
                ChatPartnerPickerView(onCreate: viewModel.onNewChannelCreation)
            }
            .navigationDestination(isPresented: $viewModel.navigateToChatRoom) {
                if let newChannel = viewModel.newChannel {
                    ChatRoomView(channel: newChannel)
                }
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
        ToolbarItemGroup(placement: .topBarTrailing) {
            cameraButton()
            newChatButton()
        }
    }
    
    // Toolbar button for new chat
    private func newChatButton() -> some View {
        Button {
            viewModel.showChatPartnerPicker = true
        } label: {
            Image(.plus)
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
