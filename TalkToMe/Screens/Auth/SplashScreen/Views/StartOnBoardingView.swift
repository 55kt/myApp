//
//  StartOnBoardingView.swift
//  TalkToMe
//
//  Created by Vlad on 28/7/24.
//

import SwiftUI

struct StartOnBoardingView: View {
    // MARK: - Properties
    @Binding var showNextView: Bool
    @State var isExpanded: Bool = false
    @State var startType: Bool = false
    @State var showText: Bool = false
    
    // MARK: - Body
    var body: some View {
        ZStack {
            
            AnimatedView(isExpanded: $isExpanded, startType: $startType, showText: $showText, color: LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing), image: "", text: "START")
            
            VStack(alignment: .leading) {
                Text("Lorem Ipsum Dolor")
                    .font(.system(size: 50))
                    .bold()
                    .foregroundStyle(.white)
            }
            .opacity(isExpanded ? 1 : 0)
            .scaleEffect(isExpanded ? 1 : 0)
            .offset(x: showText ? 0 : UIScreen.main.bounds.width)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    StartOnBoardingView(showNextView: .constant(true))
}
