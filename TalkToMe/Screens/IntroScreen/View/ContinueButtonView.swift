//
//  ContinueButtonView.swift
//  TalkToMe
//
//  Created by Vlad on 31/7/24.
//

import SwiftUI

struct ContinueButtonView: View {
    // MARK: - Properties
    @Binding var activePage: Page

    // MARK: - Body
    var body: some View {
        Button {
            activePage = activePage.nextPage
        } label: {
            Text(activePage == .page4 ? "Login to ChatMe App" : "Continue")
                .font(.title3)
                .foregroundStyle(.black.opacity(0.8))
                .padding(.vertical, 15)
                .frame(maxWidth: activePage == .page1 ? 220 : 340, maxHeight: 70)
                .background(.white, in: .capsule)
        }
        .padding(.bottom, 15)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeOut(duration: 0.5), value: activePage)
    }
}
