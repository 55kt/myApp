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
            OTPLoginScreen()
                .toolbar(.hidden)
                .navigationBarBackButtonHidden(true)
        }
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
}
