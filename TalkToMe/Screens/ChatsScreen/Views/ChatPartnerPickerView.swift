import SwiftUI

struct ChatPartnerPickerView: View {
    
    // MARK: - Properties
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ChatPartnerPickerViewModel()
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $viewModel.navStack) {
            List {
                ForEach(ChatPartnerPickerOption.allCases) { item in
                    HeaderItemView(item: item)
                        .onTapGesture {
                            viewModel.navStack.append(.groupPartnerPicker)
                        }
                }
                
                Section {
                    ForEach(0..<12) { _ in
                        ChatPartnerRow(user: .placeholder)
                    }
                } header: {
                    Text("Contacts in TalkToMe")
                        .textCase(nil)
                        .bold()
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search user")
            .navigationTitle("New Chat")
            .navigationDestination(for: ChatCreationRoute.self) { route in
                destinationView(for: route)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                trailingNavItem()
            }
        }
    }
}

// MARK: - Extensions
extension ChatPartnerPickerView {
    @ViewBuilder
    private func destinationView(for route: ChatCreationRoute) -> some View {
        switch route {
        case .groupPartnerPicker:
            GroupPartnerPickerView(viewModel: viewModel)
        case .setUpGroupChat:
            NewGroupSetUpView(viewModel: viewModel)
        }
    }
}

extension ChatPartnerPickerView {
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            cancelButton()
        }
    }
    
    private func cancelButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.footnote)
                .bold()
                .foregroundStyle(.gray)
                .padding(8)
                .background(Color(.systemGray5))
                .clipShape(Circle())
        }
    }
}

extension ChatPartnerPickerView {
    private struct HeaderItemView: View {
        let item: ChatPartnerPickerOption
        
        var body: some View {
            Button {
                // Some action
            } label: {
                buttonBody()
            }
        }
        
        private func buttonBody() -> some View {
            HStack {
                Image(systemName: item.imageName)
                    .font(.footnote)
                    .frame(width: 40, height: 40)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
                
                Text(item.title)
            }
        }
    }
}

// MARK: - Enum
enum ChatPartnerPickerOption: String, CaseIterable, Identifiable {
    case newGroup = "New Group"
    case newContact = "New Contact"
    case newComunity = "New Community"
    
    var id: String {
        return rawValue
    }
    
    var title: String {
        return rawValue
    }
    
    var imageName: String {
        switch self {
        case .newGroup:
            return "person.2.fill"
        case .newContact:
            return "person.fill.badge.plus"
        case .newComunity:
            return "person.3.fill"
        }
    }
}

// MARK: - Preview
#Preview {
    ChatPartnerPickerView()
}
