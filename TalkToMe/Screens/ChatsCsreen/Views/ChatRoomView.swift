import SwiftUI

struct ChatRoomView: View {
    
    // MARK: - Body
    var body: some View {
        MessageListView()
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                leadingNavItems()
                trailingNavItems()
            }
            .safeAreaInset(edge: .bottom) {
                TextInputArea()
            }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ChatRoomView()
    }
}
