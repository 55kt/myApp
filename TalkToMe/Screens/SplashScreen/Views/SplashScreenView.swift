//
//  ImagesView.swift
//  TalkToMe
//
//  Created by Vlad on 25/7/24.
//

import SwiftUI

struct SplashScreenView: View {
    // MARK: - Properties
    @State var showLoginView = false
    @State var show = false
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                ZStack {
                    tagline()
                    
                    womanImage(geo: geo)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .background(
                    skyImage()
                )
                LoginScreen()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .offset(y: showLoginView ? -geo.size.height : 0)
                
            }
        }
        .ignoresSafeArea()
        .onAppear() {
            withAnimation(.smooth(duration: 1.2)) {
                show.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.linear(duration: 0.8)) {
                    showLoginView = true
                }
            }
        }
    }
    
    // MARK: - Methods
    private func tagline () -> some View {
        Text("Find Talk Enjoy")
            .bold()
            .font(.system(size: 70))
            .foregroundStyle(.white)
            .opacity(show ? 1 : 0)
            .offset(y: -100)
            .offset(y: show ?0 : -50)
            .scaleEffect(show ? 1 : 1.3)
            .multilineTextAlignment(.center)
    }
    
    private func womanImage(geo: GeometryProxy) -> some View {
        Image(.womanimg)
            .resizable()
            .scaledToFit()
            .frame(width: geo.size.width)
            .position(x: geo.size.width / 2, y: geo.size.height - (geo.size.height / 4.5))
            .foregroundStyle(.black)
            .offset(y: showLoginView ? -geo.size.height : 0)
        }
    
    private func skyImage() -> some View {
        Image(.sky)
            .resizable()
            .scaledToFill()
            .scaleEffect(show ? 1 : 1.3)
    }
}

// MARK: - Preview
#Preview {
    SplashScreenView()
}
