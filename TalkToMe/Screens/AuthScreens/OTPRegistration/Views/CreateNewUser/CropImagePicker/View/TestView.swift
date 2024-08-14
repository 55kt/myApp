import SwiftUI

struct TestView: View {
    @State private var showConfirmationDialog = false
    @State private var showImagePicker = false
    @State private var showCamera = false

    var body: some View {
        VStack {
            Button(action: {
                showConfirmationDialog = true
            }) {
                Text("Choose an option")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .confirmationDialog("Select an option", isPresented: $showConfirmationDialog) {
                Button("Take a photo from library") {
                    showImagePicker = true
                }
                Button("Open Camera") {
                    showCamera = true
                }
                Button("Cancel", role: .cancel) {}
            }
            .sheet(isPresented: $showImagePicker) {
                // ImagePickerView() // Замена на ваш кастомный ImagePicker
                Text("Image Picker would be here")
            }
            .sheet(isPresented: $showCamera) {
                // CameraView() // Замена на ваш кастомный CameraView
                Text("Camera view would be here")
            }
        }
        .padding()
    }
}

#Preview {
    TestView()
}
