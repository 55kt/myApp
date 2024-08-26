import SwiftUI

struct ChatPartnerRow: View {
    let user: UserItem
    
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
        }
    }
}

#Preview {
    ChatPartnerRow(user: .placeholder)
}
