import SwiftUI

struct Home: View {
    // MARK: - Properties
    @State private var showPicker: Bool = false
    @State private var croppedImage: UIImage?
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                if let croppedImage {
                    Image(uiImage: croppedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                } else {
                    Text("No image is Selected")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            .navigationTitle("Crop Image Picker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showPicker.toggle()
                    } label: {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.callout)
                    }
                    .tint(.black)
                }
            }
            .cropImagePicker(options: [.circle], show: $showPicker, croppedImage: $croppedImage)
        }
    }
}

// MARK: - Preview
#Preview {
    Home()
}
