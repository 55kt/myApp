import SwiftUI

struct ChatRoomView: View {
    // MARK: - Properties
    let channel: ChannelItem
    
    // MARK: - Body
    var body: some View {
        MessageListView()
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                leadingNavItems()
                trailingNavItems()
            }
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .bottom) {
                TextInputArea()
            }
    }
    
    // MARK: - Methods
    @ToolbarContentBuilder
    private func leadingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack {
                Circle()
                    .frame(width: 35, height: 35)
                
                Text(channel.title)
                    .bold()
            }
        }
    }
    
    @ToolbarContentBuilder
    private func trailingNavItems() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button {
                // Some action
            } label: {
                Image(systemName: "video")
            }
            
            Button {
                // Some action
            } label: {
                Image(systemName: "phone")
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ChatRoomView(channel: .placeholder)
    }
}
