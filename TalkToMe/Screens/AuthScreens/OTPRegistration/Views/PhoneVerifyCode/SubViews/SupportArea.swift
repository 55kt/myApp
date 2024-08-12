import SwiftUI

struct SupportArea: View {
    var body: some View {
        HStack(spacing: 6) {
            Text("Didn't receive code?")
                .foregroundStyle(.white)
            
            Button {
                // Some action
            } label: {
                Text("Request again")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.mBlueColor)
            }
        }
        
        Button {
            // Some action
        } label: {
            Text("Get via call")
                .fontWeight(.bold)
                .foregroundStyle(Color.mBlueColor)
        }
        .padding(.top, 6)
    }
}

#Preview {
    SupportArea()
}
