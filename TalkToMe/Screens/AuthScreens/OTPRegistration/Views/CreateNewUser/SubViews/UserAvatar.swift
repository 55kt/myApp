import SwiftUI
import PhotosUI

struct UserAvatar: View {
    @State private var showConfirmationDialog: Bool = false
    @State private var showCamera: Bool = false
    @State private var showPhotoLibrary: Bool = false
    @State private var temporaryImage: UIImage?
    @State private var showCropView: Bool = false
    @Binding var croppedImage: UIImage?
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
                        .onTapGesture {
                            showConfirmationDialog.toggle()
                        }
                        .confirmationDialog("Select an option", isPresented: $showConfirmationDialog) {
                            Button("Take a photo from library") {
                                resetTemporaryData() // Сбрасываем временные данные
                                showPhotoLibrary = true
                            }
                            Button("Open Camera") {
                                resetTemporaryData() // Сбрасываем временные данные
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
                            resetTemporaryData() // Сбрасываем временные данные
                            showPhotoLibrary = true
                        }
                        Button("Open Camera") {
                            resetTemporaryData() // Сбрасываем временные данные
                            showCamera = true
                        }
                        Button("Cancel", role: .cancel) {}
                    }
                }
            }
            .padding(.bottom, 200)
            .sheet(isPresented: $showCamera) {
                CameraView(image: $temporaryImage)
                    .onDisappear {
                        if let image = temporaryImage {
                            croppedImage = image
                            showCropView = true // Показываем CropView только после съемки с камеры
                        }
                    }
            }
            .sheet(isPresented: $showPhotoLibrary) {
                showPhotoLibrary = true
                    .onDisappear {
                        if let image = temporaryImage {
                            croppedImage = image
                            showCropView = true // Показываем CropView только после выбора из библиотеки
                        }
                    }
            }
            .fullScreenCover(isPresented: $showCropView) {
                if let image = croppedImage {
                    CropView(crop: .circle, image: image) { cropped, status in
                        if let cropped = cropped {
                            self.croppedImage = cropped
                        }
                        showCropView = false // Закрываем CropView после завершения обрезки
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
