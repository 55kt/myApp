import SwiftUI
import PhotosUI

struct UserAvatar: View {
    @State private var userAvatar: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        VStack {
            ZStack {
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    if let userAvatar = userAvatar {
                        Image(uiImage: userAvatar)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    } else {
                        defaultAvatar()
                    }
                }
            }
        }
        .padding(.bottom, 220)
        .onChange(of: photosPickerItem) { _, _ in
            Task {
                if let photosPickerItem, let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        userAvatar = image
                    }
                }
            }
        }
    }
    
    func defaultAvatar() -> some View {
        ZStack {
            Circle()
                .padding()
                .scaledToFit()
                .frame(width: 180, height: 180)
                .foregroundStyle(.white)
                .opacity(0.5)
                .shadow(radius: 10)
            
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.white)
        }
    }
}
