import SwiftUI
import PhotosUI

struct UserAvatar: View {
    @State private var showConfirmationDialog: Bool = false
    @State private var showCamera: Bool = false
    @State private var temporaryImage: UIImage?
    @State private var showCropView: Bool = false
    @Binding var croppedImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var isShowingPhotoPicker: Bool = false
    @State private var userAvatar: UIImage?

    var body: some View {
        NavigationStack {
            VStack {
                // Top Confirmation Dialog
                if let avatar = userAvatar ?? croppedImage {
                    Image(uiImage: avatar)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                        .onTapGesture {
                            showConfirmationDialog.toggle()
                        }
                    
                    // Bottom Confirmation Dialog When Avatar is selected
                        .confirmationDialog("Select an option", isPresented: $showConfirmationDialog) {
                            Button("Crop your photo") {
                                croppedImage = avatar
                                showCropView = true
                            }
                            Button("Take a new photo from library") {
                                resetTemporaryData()
                                isShowingPhotoPicker = true
                            }
                            Button("Open Camera") {
                                resetTemporaryData()
                                showCamera = true
                            }
                            Button("Cancel", role: .cancel) {}
                        }
                } else {
                    Button {
                        showConfirmationDialog.toggle()
                    } label: {
                        defaultAvatar()
                    }
                    
                    // Bottom Confirmation Dialog When Avatar is not selected
                    .confirmationDialog("Select an option", isPresented: $showConfirmationDialog) {
                        Button("Take a photo from library") {
                            resetTemporaryData()
                            isShowingPhotoPicker = true
                        }
                        Button("Open Camera") {
                            resetTemporaryData()
                            showCamera = true
                        }
                        Button("Cancel", role: .cancel) {}
                    }
                }
            }
            .padding(.bottom, 200)
            
            // Open Camera
            .fullScreenCover(isPresented: $showCamera) {
                CameraView(image: $temporaryImage)
                    .edgesIgnoringSafeArea(.all)
                    .onDisappear {
                        if let image = temporaryImage {
                            userAvatar = image
                            croppedImage = image
                        }
                    }
            }
            
            // Open Photo Library
            .photosPicker(isPresented: $isShowingPhotoPicker, selection: $photosPickerItem, matching: .images)
            .onChange(of: photosPickerItem) { _ , newValue in
                if let newValue {
                    Task {
                        if let imageData = try? await newValue.loadTransferable(type: Data.self),
                           let image = UIImage(data: imageData) {
                            userAvatar = image
                            croppedImage = image
                        }
                        isShowingPhotoPicker = false
                    }
                }
            }
            
            // Crop Image
            .fullScreenCover(isPresented: $showCropView) {
                if let image = croppedImage {
                    CropView(
                        image: image,
                        onCrop: { cropped, status in
                            if let cropped = cropped {
                                self.croppedImage = cropped
                                self.userAvatar = cropped
                            }
                            showCropView = false
                        },
                        cropSize: CGSize(width: 350, height: 350),
                        isCircle: true
                    )
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

    private func resetTemporaryData() {
        temporaryImage = nil
        showCropView = false
    }
}
