import SwiftUI

extension ChatScreenRow {
    
    
    // MARK: - Functions
    
    // Username and time text row function
    internal func titleTextView() -> some View {
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
    internal func lastMessagePreview() -> some View {
        Text("Last message preview text here...")
            .foregroundStyle(.gray)
            .font(.system(size: 16))
            .lineLimit(2)
    }
}
