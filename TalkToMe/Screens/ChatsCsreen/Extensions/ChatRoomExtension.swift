import SwiftUI

extension ChatRoomView {
    @ToolbarContentBuilder
    internal func leadingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack {
                Circle()
                    .frame(width: 35, height: 35)
                
                Text("Username Here")
                    .bold()
            }
        }
    }
    
    @ToolbarContentBuilder
    internal func trailingNavItems() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button {
                // Some action
            } label: {
                Image(systemName: "video")
            }
            
            Button {
                // Some action
            } label: {
                Image(systemName: "phone")
            }
        }
    }
}
