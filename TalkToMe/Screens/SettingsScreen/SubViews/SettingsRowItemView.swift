import SwiftUI

struct SettingsRowItemView: View {
    // MARK: - Properties
    let item: SettingsRowItemModel
    
    // MARK: - Body
    var body: some View {
        HStack {
            iconImageView()
                .frame(width: 30, height: 30)
                .foregroundStyle(.white)
                .background(item.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            
            Text(item.title)
                .font(.system(size: 18))
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func iconImageView() -> some View {
        switch item.imageType {
        case .systemImage:
            Image(systemName: item.imageName)
                .bold()
                .font(.callout)
            
        case .assetImage:
            Image(systemName: item.imageName)
                .renderingMode(.template)
                .padding(3)
        }
    }
}

// MARK: - Preview
#Preview {
    SettingsRowItemView(item: .encryption)
}
