//
//  SecondOnBoardingView.swift
//  TalkToMe
//
//  Created by Vlad on 28/7/24.
//

import SwiftUI

struct SecondOnBoardingView: View {
    // MARK: - Properties
    @Binding var showNextView: Bool
    @State var isExpanded: Bool = false
    @State var startType: Bool = false
    @State var showText: Bool = false
    
    // MARK: - Body
    var body: some View {
        ZStack {
            
            AnimatedView(isExpanded: $isExpanded, startType: $startType, showText: $showText, color: LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing), image: "")
            
            VStack(alignment: .leading) {
                Text("Lorem Ipsum Dolor")
                    .font(.system(size: 50))
                    .bold()
                    .foregroundStyle(.white)
                
                TypingEffect(fullText: """
lorem ipsum dolor dnfa hjdafhasdhf uhpdauhfuh dfuhodsuHf. uhDOfuhoiuDsfjhgsadhghgdskfhg uih fhiasuh fikuash fkaiu fhash fi.

df;lkjaksjdghkajsdkjhgkajsd;gjkjasdkgjhlkajshdgklhladsghlkjahsdglkjhsladjghjshad.

adsokgjoaud hasd hgoiuash uhio hguahsВп рш пгфырвпп гшпрфышв п

""", isExpended: $startType)
                
                
            }
            .opacity(isExpanded ? 1 : 0)
            .scaleEffect(isExpanded ? 1 : 0)
            .offset(x: showText ? 0 : UIScreen.main.bounds.width)
        }
        .ignoresSafeArea()
    }
}
