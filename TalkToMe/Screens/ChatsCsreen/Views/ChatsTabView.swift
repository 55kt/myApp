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
                    ChatScreenRow()
                }
                
                inboxFooterView()
                    .listRowSeparator(.hidden)
            }
            .navigationTitle("Chats")
            .searchable(text: $searchText)
            .listStyle(.plain)
            .toolbar {
                leadingNavItems()
                trailingNavItems()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ChatsTabView()
    }
}
