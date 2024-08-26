import SwiftUI

struct AddGroupChatPartnerView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: ChatPartnerPickerViewModel
    @State private var searchText = ""
    
    // MARK: - Body
    var body: some View {
        List {
            Section {
                ForEach(0..<12) { _ in
                    Button {
                        print("Item selected")
                    } label: {
                        chatPartnerRow(.placeholder)
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }
    
    private func chatPartnerRow(_ user: UserItem) -> some View {
        ChatPartnerRow(user: .placeholder) {
            Spacer()
            Image(systemName: "circle")
                .foregroundStyle(Color(.systemGray4))
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
