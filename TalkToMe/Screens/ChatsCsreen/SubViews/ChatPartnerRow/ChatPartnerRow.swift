import SwiftUI

struct ChatPartnerRow<Content: View>:  View {
    // MARK: - Properties
    private let user: UserItem
    private let trailingItems: Content
    
    // MARK: - Initializer
    init(user: UserItem, @ViewBuilder trailingItems: () -> Content = { EmptyView() }) {
        self.user = user
        self.trailingItems = trailingItems()
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            Circle()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .bold()
                    .foregroundStyle(.talkToMeAppBlack)
                
                Text(user.bioUnwrapped)
                    .foregroundStyle(.gray)
            }
            
            trailingItems
        }
    }
}

// MARK: - Preview
#Preview {
    ChatPartnerRow(user: .placeholder)
}
