//
//  ImagesView.swift
//  TalkToMe
//
//  Created by Vlad on 25/7/24.
//

import SwiftUI

struct ImagesView: View {
    // MARK: - Properties
    @State var showHomeView = false
    @State var show = false
    
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                ZStack {
                    Text("Find Talk Enjoy")
                        .bold()
                        .font(.system(size: 70))
                        .foregroundStyle(.white)
                        .opacity(show ? 1 : 0)
                        .offset(y: -100)
                        .offset(y: show ?0 : -50)
                        .scaleEffect(show ? 1 : 1.3)
                        .multilineTextAlignment(.center)
                    
                    Image(.womanimg).renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .position(x: geo.size.width / 2, y: geo.size.height - (geo.size.height / 4.5))
                        .foregroundStyle(.black)
                        .offset(y: showHomeView ? -geo.size.height : 0)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .background(
                    Image(.sky)
                        .resizable()
                        .scaledToFill()
                )
                HomeView()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .offset(y: showHomeView ? -geo.size.height : 0)
                
            }
        }
        .ignoresSafeArea()
        .onAppear() {
            withAnimation(.smooth(duration: 2)) {
                show.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.linear(duration: 1)) {
                    showHomeView = true
                }
            }
        }
    }
}

#Preview {
    ImagesView()
}
