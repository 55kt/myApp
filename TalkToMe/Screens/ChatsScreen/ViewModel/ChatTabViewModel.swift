import Foundation

final class ChatTabViewModel: ObservableObject {
    
    @Published var navigateToChatRoom = false
    @Published var newChannel: ChannelItem?
    @Published var showChatPartnerPicker: Bool = false
    
    func onNewChannelCreation(_ channel: ChannelItem) {
        showChatPartnerPicker = false
        newChannel = channel
        navigateToChatRoom = true
    }
}
