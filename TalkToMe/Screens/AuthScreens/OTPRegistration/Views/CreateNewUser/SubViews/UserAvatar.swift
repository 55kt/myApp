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
                if let avatar = userAvatar ?? croppedImage {
                    Image(uiImage: avatar)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                        .onTapGesture {
                            showConfirmationDialog.toggle()
                        }
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
            .fullScreenCover(isPresented: $showCropView) {
                if let image = croppedImage {
                    CropView(crop: .circle, image: image) { cropped, status in
                        if let cropped = cropped {
                            self.croppedImage = cropped
                            self.userAvatar = cropped
                        }
                        showCropView = false 
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

    private func resetTemporaryData() {
        temporaryImage = nil
        showCropView = false
    }
}
