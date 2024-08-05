//
//  GradientBackground.swift
//  TalkToMe
//
//  Created by Vlad on 28/7/24.
//

import SwiftUI

struct IntroGradient: View {
    var body: some View {
        LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(red: 0.9, green: 0.5, blue: 0.0), location: 0.1),
                        .init(color: Color(red: 0.8, green: 0.4, blue: 0.2), location: 0.5),
                        .init(color: Color(red: 0.0, green: 0.6, blue: 1.0), location: 1.0)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
        .ignoresSafeArea(.all)
    }
}

#Preview {
    IntroGradient()
}
