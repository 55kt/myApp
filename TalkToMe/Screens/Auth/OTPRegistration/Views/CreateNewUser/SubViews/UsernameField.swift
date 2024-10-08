import SwiftUI

struct UsernameField: View {
    @Binding var textPlaceholder: String
    @Binding var boolPlaceholder: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "number.circle")
                .resizable()
                .frame(width: 33, height: 30)
                .fontWeight(.semibold)
                .frame(width: 30)
            
            TextField("Username", text: $textPlaceholder).font(.title3)
                .shadow(radius: 10)
                
        }
        .foregroundStyle(.white)
        .padding()
        .background(Color.white.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 16)
        .padding(.top, boolPlaceholder ? 180 : 50)
    }
}
