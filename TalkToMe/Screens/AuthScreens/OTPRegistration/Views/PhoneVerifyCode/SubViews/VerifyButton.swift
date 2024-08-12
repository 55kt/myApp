import SwiftUI

struct VerifyButton: View {
    var boolPlaceholder: Bool
    
    var body: some View {
        NavigationLink(destination: CreateUserScreenView()) {
            Text("Verify and Create Account")
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .medium))
                .padding(.vertical, 18)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(boolPlaceholder ? Color.yellow : Color.white.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .disabled(!boolPlaceholder)
                .padding(.horizontal, 20)
        }
    }
}
