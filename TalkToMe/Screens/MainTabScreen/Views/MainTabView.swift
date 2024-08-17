import SwiftUI

struct MainTabView: View {
    @State private var scrollOffset: CGFloat = 0
    
    // MARK: - Initializer
    
    
    // MARK: - Body
    var body: some View {
        TabView {
            placeholderItemView("Chats")
                .tabItem {
                    Image(systemName: Tab.chats.icon)
                    Text(Tab.chats.title)
                }
            placeholderItemView("Chat Search")
                .tabItem {
                    Image(systemName: Tab.chatsearch.icon)
                    Text(Tab.chatsearch.title)
                }
            placeholderItemView("Settings")
                .tabItem {
                    Image(systemName: Tab.settings.icon)
                    Text(Tab.settings.title)
                }
        }
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
}
