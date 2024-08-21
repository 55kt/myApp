import SwiftUI
import UIKit

extension MainTabView {

    // Add a placeholder item
    internal func placeholderItemView(_ title: String) -> some View {
        ScrollView {
            VStack {
                ForEach(0..<12) { _ in
                    Text(title)
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 120)
                        .background(Color.red.opacity(0.8))
                }
            }
        }
    }
    
    // Tab bar enum
    enum Tab: String {
        case chats, chatsearch, settings
        
        internal var title: String {
            return rawValue.capitalized
        }
        
        internal var icon: String {
            switch self {
            case .chats: return "bubble.right"
            case .chatsearch: return "magnifyingglass.circle.fill"
            case .settings: return "gearshape"
            }
        }
    }
}
