//
//  ImagesView.swift
//  TalkToMe
//
//  Created by Vlad on 25/7/24.
//

import SwiftUI

struct SplashScreenView: View {
    // MARK: - Properties
    @State var showNextView = false
    @State var show = false
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                ZStack {
                    tagline()
                    
                    (geo: geo) // In front of these brackets paste your image who go up
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .background(
                    // Your Background Image Here
                )
                // Here past your next view
                    .frame(width: geo.size.width, height: geo.size.height)
                    .offset(y: showNextView ? -geo.size.height : 0)
            }
        }
        .ignoresSafeArea()
        .onAppear() {
            withAnimation(.smooth(duration: 1.2)) {
                show.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.linear(duration: 0.8)) {
                    showNextView = true
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
    
    private func yourImageWhoGoUp(geo: GeometryProxy) -> some View {
        Image(.womanimg)
            .resizable()
            .scaledToFit()
            .frame(width: geo.size.width)
            .position(x: geo.size.width / 2, y: geo.size.height - (geo.size.height / 4.5))
            .foregroundStyle(.black)
            .offset(y: showNextView ? -geo.size.height : 0)
        }
    
    private func yourImageWhoIsBackground() -> some View {
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
