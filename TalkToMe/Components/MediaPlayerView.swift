import SwiftUI
import AVKit

struct MediaPlayerView: View {
    // MARK: - Properties
    let player: AVPlayer
    let dismissPlayer: () -> Void
    
    // MARK: - Body
    var body: some View {
        VideoPlayer(player: player)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .overlay(alignment: .topLeading) {
                cancelButton()
                    .padding()
            }
            .onAppear { player.play() }
    }
    
    // MARK: - Methods
    private func cancelButton() -> some View {
        Button {
            dismissPlayer()
        } label: {
            Image(systemName: "xmark")
                .scaledToFit()
                .imageScale(.large)
                .padding(10)
                .foregroundStyle(.white)
                .background(Color.white.opacity(0.5))
                .clipShape(Circle())
                .shadow(radius: 5)
                .padding(2)
                .bold()
        }
    }
}

//// MARK: - Preview
//#Preview {
//    MediaPlayerView(player: <#AVPlayer#>)
//}
