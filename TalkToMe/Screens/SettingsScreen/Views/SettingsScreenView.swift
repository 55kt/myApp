import SwiftUI

struct SettingsScreenView: View {
    
    // MARK: - Properties
    @State private var searchText = ""
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                SettingsHeaderView()
             
                Section {
                    SettingsRowItemView(item: .broadCastLists)
                    SettingsRowItemView(item: .starredMessages)
                    SettingsRowItemView(item: .linkedDevices)
                }
                
                Section {
                    SettingsRowItemView(item: .account)
                    SettingsRowItemView(item: .privacy)
                    SettingsRowItemView(item: .chats)
                    SettingsRowItemView(item: .notifications)
                    SettingsRowItemView(item: .storage)
                }
                
                Section {
                    SettingsRowItemView(item: .help)
                    SettingsRowItemView(item: .tellFriend)
                }
            }
            .navigationTitle("Settings")
            .searchable(text: $searchText)
            .toolbar {
                leadingNavItem()
            }
        }
    }
}

extension SettingsScreenView {
    @ToolbarContentBuilder
    private func leadingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Sign Out") {
                Task {
                    try? await AuthManager.shared.logOut()
                }
            }
            .foregroundStyle(.red)
        }
    }
}

// MARK: - Preview
#Preview {
    SettingsScreenView()
}
