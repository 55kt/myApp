import SwiftUI

struct SettingsHeaderView: View {
    
    // MARK: - Body
    var body: some View {
        Section {
            HStack {
                Circle()
                    .frame(width: 55, height: 55)
                
                userInfoTextView()
            }
            
            SettingsRowItemView(item: .avatar)
        }
    }
    
    // MARK: - Methods
    // Fucntion to display user info
    private func userInfoTextView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Username Here")
                    .font(.title2)
                
                Spacer()
                
                Image(.qrcode)
                    .renderingMode(.template)
                    .padding(5)
                    .foregroundStyle(.blue)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }
            
            Text("Hello, I am using TalkToMe")
                .foregroundStyle(.gray)
                .font(.callout)
        }
        .lineLimit(1)
    }
}

// MARK: - Preview
#Preview {
    SettingsHeaderView()
}
