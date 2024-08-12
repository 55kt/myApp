import SwiftUI

import SwiftUI

struct TextTabHolderView: View {
    // MARK: - Properties
    @Binding var activePage: Page
    var size: CGSize
    
    // MARK: - Body
    var body: some View {
        TabView(selection: $activePage) {
            ForEach(Page.allCases, id: \.rawValue) { page in
                VStack(spacing: 8) {
                    Text(page.title)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .font(.title)
                        .fontWeight(.bold)
                        .kerning(1.1)
                                            
                    Text(page.subTitle)
                        .bold()
                        .font(.callout)
                        .foregroundStyle(.white.opacity(0.8))
                        .frame(width: size.width)
                        .multilineTextAlignment(.center)
                        .frame(width: size.width, alignment: .leading)
                }
                .tag(page)
                .padding(.top, 15)
                .frame(width: size.width, alignment: .leading)
            }
        }
        .frame(width: size.width, alignment: .leading)
        .frame(height: 150)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}
