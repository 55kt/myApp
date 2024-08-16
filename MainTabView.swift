import SwiftUI

struct MainTabView: View {
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            OTPPhoneVerifyCodeView(loginData: OTPViewModel())
        }
    }
}

// MARK: - Preview
#Preview {
    MainTabView()

}
