import SwiftUI

struct IntroView: View {
    // MARK: - Properties
    @State private var activePage: Page = .page1
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            GeometryReader {
                let size = $0.size
                
                VStack {
                    Spacer(minLength: 0)
                    
                    // Animated Icon
                    MorphingSymbolView(
                        symbol: activePage.rawValue,
                        config: .init(
                            font: .system(size: 200, weight: .bold),
                            frame: .init(width: 390, height: 250),
                            radius: 30,
                            foregroundColor: .white
                        )
                    )
                    .padding(.bottom, -70)
                    
                    TextTabHolderView(activePage: $activePage, size: size)
                    
                    IndicatorView(activePage: $activePage)
                    
                    Spacer(minLength: 0)
                    
                    // Show button in last page
                    if activePage == .page4 {
                        ContinueButtonView(activePage: $activePage)
                    }
                }
                .frame(maxWidth: .infinity)
                .overlay(alignment: .top) {
                    HeaderView(activePage: $activePage)
                }
            }
            .shadow(radius: 10)
            .background {
                IntroGradient()
                    .ignoresSafeArea()
            }
        }
    }
}
    
// MARK: - Preview
#Preview {
    MainTabView(.placeholder)
}
