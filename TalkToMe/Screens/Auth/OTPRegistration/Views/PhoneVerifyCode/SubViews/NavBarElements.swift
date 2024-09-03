import SwiftUI

struct NavBarElements: View {
    var phoneNumberPlaceholder: String

    @Environment(\.presentationMode) var present

    
    var body: some View {
        HStack {
            Button {
                present.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .bold()
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            Text("Verify your phone number")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            
            Spacer()
        }
        .padding()
        
        Text("Code sent to \(phoneNumberPlaceholder)")
            .foregroundStyle(.white)
            .padding(.bottom)
    }
}
