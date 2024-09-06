import SwiftUI

struct MediaAttachmentPreview: View {
    // MARK: - Properties
    let selectedPhotos: [UIImage]
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                audioAttachmentPreview()
                ForEach(selectedPhotos, id: \.self) { image in
                    thumbnailImageView(image)
                }
            }
        }
        .frame(height: Constants.listHeight)
        .frame(maxWidth: .infinity)
        .background(.whatsAppWhite)
    }
    
    // MARK: - Methods
    private func thumbnailImageView(_ image: UIImage) -> some View {
        Button {
            // Some action
        } label: {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: Constants.imageDimen, height: Constants.imageDimen)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .clipped()
                .overlay(alignment: .topTrailing) {
                    cancelButton()
                }
                .overlay {
                    playButton("play.fill")
                }
        }
    }
    
    private func cancelButton() -> some View {
        Button {
            // Some action
        } label: {
            Image(systemName: "xmark")
                .scaledToFit()
                .imageScale(.small)
                .padding(5)
                .foregroundStyle(.white)
                .background(Color.white.opacity(0.5))
                .clipShape(Circle())
                .shadow(radius: 5)
                .padding(2)
                .bold()
        }
    }
    
    private func playButton(_ systemName: String) -> some View {
        Button {
            // Some action
        } label: {
            Image(systemName: systemName)
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
    
    private func audioAttachmentPreview() -> some View {
        ZStack {
            LinearGradient(colors: [.green, .green.opacity(0.8), .teal], startPoint: .topLeading, endPoint: .bottom)
            playButton("mic.fill")
        }
        .frame(width: Constants.imageDimen * 2, height: Constants.listHeight)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .clipped()
        .overlay(alignment: .topTrailing) {
            cancelButton()
        }
        .overlay(alignment: .bottomLeading) {
            Text("Test mp3 file name here")
                .lineLimit(1)
                .font(.caption)
                .padding(2)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundStyle(.white)
                .background(Color.white.opacity(0.5))
        }
    }
}

// MARK: - Extensions
extension MediaAttachmentPreview {
    enum Constants {
        static let listHeight: CGFloat = 100
        static let imageDimen: CGFloat = 80
    }
}

// MARK: - Preview
#Preview {
    MediaAttachmentPreview(selectedPhotos: [])
}
