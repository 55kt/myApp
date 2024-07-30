//
//  ContentView.swift
//  TalkToMe
//
//  Created by Vlad on 25/7/24.
//

import SwiftUI

struct MainTabView: View {
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            IntroView()
                .environment(\.colorScheme, .dark)
        }
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
}
