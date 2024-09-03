import SwiftUI

struct NavPlaceHolder: View {
    var body: some View {
        VStack {
            Text("Continue with your phone number")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding()
            
            Image(systemName: "platter.filled.top.and.arrow.up.iphone")
                .resizable()
                .frame(width: 80, height: 130)
                .foregroundStyle(.white)
            
            
            Text("You`ll receive a 6 digit code\n to verify next")
                .font(.title2)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
        }
        .shadow(radius: 10)
    }
}
