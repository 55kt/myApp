import SwiftUI
import AVKit

struct BubbleAudioView: View {
    
    // MARK: - Properties
    @EnvironmentObject private var voiceMessagePlayer: VoiceMessagePlayer
    @State private var playbackState: VoiceMessagePlayer.PlaybackState = .stopped
    
    private let item: MessageItem
    @State private var sliderValue: Double = 0
    @State private var sliderRange: ClosedRange<Double>
    @State private var playbackTime = "00:00"
    @State private var isDraggingSlider = false
    
    init(item: MessageItem) {
        self.item = item
        let audioDuration = item.audioDuration ?? 20
        self._sliderRange = State(wrappedValue: 0...audioDuration)
    }
    
    private var isCorrectVoiceMessage: Bool {
        voiceMessagePlayer.currentURL?.absoluteString == item.audioURL
    }
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .bottom, spacing: 3) {
            
            if item.showGroupPartnerInfo {
                CircularProfileImageView(item.sender?.profileImageUrl, size: .mini)
                    .offset(y: 3)
            }
            
            if item.direction == .sent {
                timeStampTextView()
            }
            
            HStack {
                playButton()
                Slider(value: $sliderValue, in: sliderRange) { editing in
                    isDraggingSlider = editing
                    if !editing && isCorrectVoiceMessage {
                        voiceMessagePlayer.seek(to: sliderValue)
                    }
                }
                    .tint(.gray)
                
                if playbackState == .stopped {
                    Text(item.audioDurationInString)
                        .foregroundStyle(.gray)
                } else {
                    Text(playbackTime)
                        .foregroundStyle(.gray)
                }
            }
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(5)
            .background(item.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .applyTail(item.direction)
            
            if item.direction == .received {
                timeStampTextView()
            }

        }
        .shadow(color: Color(.systemGray3).opacity(0.1), radius: 5, x: 0, y: 20)
        .frame(maxWidth: .infinity, alignment: item.alignment)
        .padding(.leading, item.leadingPadding)
        .padding(.trailing, item.trailingPadding)
        .overlay(alignment: item.reactionAnchor) {
            MessageReactionView(message: item)
                .offset(x: item.showGroupPartnerInfo ? 50 : 0, y: 17)
        }
        .onReceive(voiceMessagePlayer.$playbackState) { state in
            observePlaybackState(state)
        }
        .onReceive(voiceMessagePlayer.$currentTime) { currentTime in
            guard voiceMessagePlayer.currentURL?.absoluteString == item.audioURL else { return }
            listen(to: currentTime)
        }
    }
    
    // MARK: - Methods
    private func playButton() -> some View {
        Button {
            handlePlayVoiceMessage()
        } label: {
            Image(systemName: playbackState.icon)
                .padding(10)
                .background(item.direction == .received ? .green : .white)
                .clipShape(Circle())
                .foregroundStyle(item.direction == .received ? .white : .black)
        }
    }
    
    private func timeStampTextView() -> some View {
        Text(item.timeStamp.formatToTime)
            .font(.footnote)
            .foregroundStyle(.gray)
    }
}

// MARK: - Extensions
extension BubbleAudioView {
    private func handlePlayVoiceMessage() {
        if playbackState == .stopped || playbackState == .paused {
            guard let audioURLString = item.audioURL, let voiceMessageUrl = URL(string: audioURLString) else { return }
            voiceMessagePlayer.playAudio(from: voiceMessageUrl)
        } else {
            voiceMessagePlayer.pauseAudio()
        }
    }
    
    private func observePlaybackState(_ state: VoiceMessagePlayer.PlaybackState) {
        switch state {
        case .stopped:
            playbackState = .stopped
            sliderValue = 0
        case .playing, .paused:
            if isCorrectVoiceMessage {
                playbackState = state
            }
        }
    }
    
    private func listen(to currentTime: CMTime) {
        guard !isDraggingSlider else { return }
        playbackTime = currentTime.seconds.formatElapsedTime
        sliderValue = currentTime.seconds
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        BubbleAudioView(item: .receivedPlaceholder)
        BubbleAudioView(item: .sentPlaceholder)

    }
    .environmentObject(VoiceMessagePlayer())
    .frame(maxWidth: .infinity)
    .padding(.horizontal)
    .background(Color.gray.opacity(0.4))
    .onAppear {
        let thumbImage = UIImage(systemName: "circle.fill")
        UISlider.appearance().setThumbImage(thumbImage, for: .normal)
    }
}
