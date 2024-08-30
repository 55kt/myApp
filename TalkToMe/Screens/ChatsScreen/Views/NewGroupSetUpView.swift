import SwiftUI

struct NewGroupSetUpView: View {
    // MARK: - Properties
    @State private var channelName = ""
    @ObservedObject var viewModel: ChatPartnerPickerViewModel
    var onCreate: (_ newChannel: ChannelItem) -> ()
    
    // MARK: - Body
    var body: some View {
        List {
            Section {
                channelSetUpHeaderView()
            }
            
            Section {
                Text("Disappearing Messages")
                Text("Group Permissions")
            }
            
            Section {
                SelectedChatPartnerView(users: viewModel.selectedChatPartners) { user in
                    viewModel.handleItemSelection(user)
                }
            } header: {
                let count = viewModel.selectedChatPartners.count
                let maxCount = ChatContants.maxGroupMembers
                
                Text("Participants: \(count) of \(maxCount)")
                    .bold()
            }
            .listRowBackground(Color.clear)
        }
        .navigationTitle("New Group")
        .toolbar {
            trailingNavItem()
        }
    }
    
    // MARK: - Methods
    private func channelSetUpHeaderView() -> some View {
        HStack {
            profileImageView()
            
            TextField("", text: $channelName, prompt: Text("Group Name (optional)"), axis: .vertical)
        }
    }
    
    private func profileImageView() -> some View {
        Button {
            // Some action
        } label: {
            ZStack {
                Image(systemName: "camera.fill")
                    .imageScale(.large)
            }
            .frame(width: 60, height: 60)
            .background(Color(.systemGray6))
            .clipShape(Circle())
        }
    }
    
    // Create Group Button
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Create") {
                viewModel.createGroupChannel(channelName, completion: onCreate)
            }
            .bold()
            .disabled(viewModel.disableNextButton)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        NewGroupSetUpView(viewModel: ChatPartnerPickerViewModel()) { _ in
            
        }
    }
}
