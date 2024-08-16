import SwiftUI

struct FinalScreenView: View {
    @State private var textScale: CGFloat = 1.0
    @State private var textOpacity: Double = 1.0
    @State private var showMainView = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                IntroGradient()
                
                if showMainView {
                    TestView() // Замените на ваше главное представление
                } else {
                    VStack(spacing: 0) {
                        Text("Done")
                            .font(.system(size: geometry.size.width * 0.3)) // Размер текста зависит от ширины экрана
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Text("Good Chatting")
                            .font(.system(size: geometry.size.width * 0.05)) // Меньший размер для второго текста
                            .foregroundStyle(.white)
                            .padding(.top, -20) // Сдвиг текста вверх для более плотного расположения строк
                    }
                    .scaleEffect(textScale)
                    .opacity(textOpacity)
                    .onAppear {
                        withAnimation(.easeOut(duration: 4.0)) { // Увеличиваем продолжительность анимации для плавного ухода текста
                            textScale = 0.9
                            textOpacity = 0.0
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { // Переход на TestView после завершения анимации
                            showMainView = true
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Центрируем текст по экрану
                    .padding()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height) // Гарантируем использование размеров экрана
        }
    }
}

#Preview {
    FinalScreenView()
}
