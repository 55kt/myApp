import SwiftUI

struct NewGroupSetUpView: View {
    // MARK: - Properties
    @State private var text = ""
    @ObservedObject var viewModel: ChatPartnerPickerViewModel
    
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
                Text("Participants 12 OF 12")
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
            Circle()
                .frame(width: 60, height: 60)
            
            TextField("", text: $text, prompt: Text("Group Name (optional)"), axis: .vertical)
        }
    }
    // Create Group Button
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Create") {
                
            }
            .bold()
            .disabled(viewModel.disableNextButton)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        NewGroupSetUpView(viewModel: ChatPartnerPickerViewModel())
    }
}
