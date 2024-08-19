import SwiftUI

struct ChatRoomView: View {
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<12) { _ in
                    Text("Placeholder")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .background(Color.gray.opacity(0.1))
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                leadingNavItems()
                trailingNavItems()
            }
        }
        .safeAreaInset(edge: .bottom) {
            TextInputArea()
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ChatRoomView()
    }
}
