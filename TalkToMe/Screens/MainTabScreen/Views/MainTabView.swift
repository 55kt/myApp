import SwiftUI

struct MainTabView: View {
    
    init() {
        let thumbImage = UIImage(systemName: "circle.fill")
        UISlider.appearance().setThumbImage(thumbImage, for: .normal)
    }
    
    // MARK: - Body
    var body: some View {
        TabView {
            ChatsTabView()
                .tabItem {
                    Image(systemName: Tab.chats.icon)
                    Text(Tab.chats.title)
                }
            placeholderItemView("Chat Search")
                .tabItem {
                    Image(systemName: Tab.chatsearch.icon)
                    Text(Tab.chatsearch.title)
                }
            SettingsScreenView()
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
