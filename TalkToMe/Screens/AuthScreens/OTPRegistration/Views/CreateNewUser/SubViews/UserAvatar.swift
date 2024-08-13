import SwiftUI
import PhotosUI

struct UserAvatar: View {
    @State private var showPicker: Bool = false
    @State private var croppedImage: UIImage?
    @State private var userAvatar: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        NavigationStack {
            VStack {
                if let croppedImage {
                    Image(uiImage: croppedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .frame(width: 180, height: 180)
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                } else {
                    Button {
                        showPicker.toggle()
                    } label: {
                        defaultAvatar()
                    }
                    .cropImagePicker(options: [.circle], show: $showPicker, croppedImage: $croppedImage)
                }
            }
            .padding(.bottom, 200)
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


