import SwiftUI

struct SelectedChatPartnerView: View {
    // MARK: - Properties
    let users: [UserItem]
    let onTapHandler: (_ user: UserItem) -> ()
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(users) { item in
                    chatParnerView(item)
                }
            }
        }
    }
    
    // MARK: - Methods
    private func chatParnerView(_ user: UserItem) -> some View {
        VStack {
            Circle()
                .fill(.gray)
                .frame(width: 60, height: 60)
                .overlay(alignment: .topTrailing) {
                    cancelButton(user)
                }
            
            Text(user.username)
        }
    }
    
    private func cancelButton(_ user: UserItem) -> some View {
        Button {
            onTapHandler(user)
        } label: {
            Image(systemName: "xmark")
                .imageScale(.small)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .padding(5)
                .background(Color(.systemGray2))
                .clipShape(Circle())
        }
    }
}

// MARK: - Preview
#Preview {
    SelectedChatPartnerView(users: UserItem.plaseholders) { user in
        
    }
}
