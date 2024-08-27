
import SwiftUI

struct GroupPartnerPickerView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: ChatPartnerPickerViewModel
    @State private var searchText = ""
    
    // MARK: - Body
    var body: some View {
        List {
            if viewModel.showSelectedUsers {
                SelectedChatPartnerView(users: viewModel.selectedChatPartners) { user in
                    viewModel.handleItemSelection(user)
                }
            }
            Section {
                ForEach(UserItem.plaseholders) { item in
                    Button {
                        viewModel.handleItemSelection(item)
                    } label: {
                        chatPartnerRow(item)
                    }
                }
            }
        }
        .animation(.easeInOut, value: viewModel.showSelectedUsers)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search user")
        .toolbar {
            titleView()
            trailingNavItem()
        }
    }
    
    // MARK: - Methods
    private func chatPartnerRow(_ user: UserItem) -> some View {
        ChatPartnerRow(user: user) {
            Spacer()
            let isSelected = viewModel.isUserSelected(user)
            let imageName = isSelected ? "checkmark.circle.fill" : "circle"
            let foregroundStyle = isSelected ? Color.blue : Color(.systemGray4)
            Image(systemName: imageName)
                .foregroundStyle(foregroundStyle)
                .imageScale(.large)
        }
    }
}

// MARK: - Extensions
extension GroupPartnerPickerView {
    @ToolbarContentBuilder
    private func titleView() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            VStack {
                Text("Add Group Members")
                    .bold()
                
                let count = viewModel.selectedChatPartners.count
                let maxCount = ChatContants.maxGroupMembers
                Text("\(count)/\(maxCount)")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
        }
    }
    
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Next") {
                viewModel.navStack.append(.setUpGroupChat)
            }
            .bold()
            .disabled(viewModel.disableNextButton)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        GroupPartnerPickerView(viewModel: ChatPartnerPickerViewModel())
    }
}
