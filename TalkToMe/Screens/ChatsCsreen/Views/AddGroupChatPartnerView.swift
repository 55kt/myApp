import SwiftUI

struct AddGroupChatPartnerView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: ChatPartnerPickerViewModel
    @State private var searchText = ""
    
    // MARK: - Body
    var body: some View {
        List {
            if viewModel.showSelectedUsers {
                Text("Selected Users")
            }
            Section {
                ForEach([UserItem.placeholder]) { item in
                    Button {
                        viewModel.handleItemSelection(item)
                    } label: {
                        chatPartnerRow(.placeholder)
                    }
                }
            }
        }
        .animation(.easeInOut, value: viewModel.showSelectedUsers)
        .searchable(text: $searchText)
    }
    
    private func chatPartnerRow(_ user: UserItem) -> some View {
        ChatPartnerRow(user: .placeholder) {
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

// MARK: - Preview
#Preview {
    NavigationStack {
        AddGroupChatPartnerView(viewModel: ChatPartnerPickerViewModel())
    }
}
