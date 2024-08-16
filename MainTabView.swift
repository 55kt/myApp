import SwiftUI

struct MainTabView: View {
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            CreateUserScreenView()
        }
    }
}

// MARK: - Preview
#Preview {
    MainTabView()

}
