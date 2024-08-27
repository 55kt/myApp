import SwiftUI

struct ChatScreenRow: View {
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 3) {
                titleTextView()
                lastMessagePreview()
            }
        }
    }
    
    // MARK: - Methods
    // Username and time text row function
    private func titleTextView() -> some View {
        HStack {
            Text("Username Here")
                .lineLimit(1)
                .bold()
            
            Spacer()
            
            Text("5:55 PM")
                .foregroundStyle(.gray)
                .font(.system(size: 15))
        }
    }
    
    // Last message preview text row function
    private func lastMessagePreview() -> some View {
        Text("Last message preview text here...")
            .foregroundStyle(.gray)
            .font(.system(size: 16))
            .lineLimit(2)
    }
}

#Preview {
    ChatScreenRow()
}
