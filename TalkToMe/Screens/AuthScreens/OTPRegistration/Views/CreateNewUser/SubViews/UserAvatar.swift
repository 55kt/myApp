import SwiftUI

struct UserAvatar: View {
    
    var body: some View {
        VStack {
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
        .padding(.bottom, 220)
    }
}
