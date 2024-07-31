//
//  IndicatorView.swift
//  TalkToMe
//
//  Created by Vlad on 31/7/24.
//

import SwiftUI

struct IndicatorView: View {
    // MARK: - Properties
    @Binding var activePage: Page
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 6) {
            ForEach(Page.allCases, id: \.rawValue) { page in
                Capsule()
                    .fill(.white.opacity(activePage == page ? 1 : 0.4))
                    .frame(width: activePage == page ? 25 : 8, height: 8)
            }
        }
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
        .padding(.bottom, 12)
    }
}
