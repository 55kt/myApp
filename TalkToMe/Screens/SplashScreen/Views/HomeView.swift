//
//  HomeView.swift
//  TalkToMe
//
//  Created by Vlad on 25/7/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Home View")
                .bold()
                .font(.system(size: 70))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
