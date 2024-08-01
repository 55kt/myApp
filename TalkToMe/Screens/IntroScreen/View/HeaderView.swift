//
//  HeaderView.swift
//  TalkToMe
//
//  Created by Vlad on 31/7/24.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - Properties
    @Binding var activePage: Page

    // MARK: - Body
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            
            Button {
                activePage = .page4
            } label: {
                Text("Skip")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .opacity(activePage != .page4 ? 1 : 0)
            }
            .animation(.smooth(duration: 0.35, extraBounce: 0), value: activePage)
            .padding(15)
        }
    }
}
