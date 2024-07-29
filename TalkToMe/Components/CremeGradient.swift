//
//  GradientBackground.swift
//  TalkToMe
//
//  Created by Vlad on 28/7/24.
//

import SwiftUI

struct CremeGradient: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color(red: 1.0, green: 0.9, blue: 0.8), Color(red: 1.0, green: 0.8, blue: 0.6)]),
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    CremeGradient()
}
