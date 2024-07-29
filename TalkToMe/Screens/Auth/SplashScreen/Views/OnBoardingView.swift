//
//  OnBoardingView.swift
//  TalkToMe
//
//  Created by Vlad on 28/7/24.
//

//import Foundation
import SwiftUI

struct OnBoardingView: View {
    // MARK: - Properties
    @State private var showSView: Bool = false
    @State private var showTView: Bool = false
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Text("SwiftUICodes OnBoarding").bold().font(.largeTitle)
                .offset(y: -50)
                .multilineTextAlignment(.center)
            
            FirstOnBoardingView(showNextView: $showSView)
            
            SecondOnBoardingView(showNextView: $showSView).modifier(ViewAnimation(isShow: showSView))
            
            StartOnBoardingView(showNextView: $showTView).modifier(ViewAnimation(isShow: showTView))
        }
    }
}

#Preview {
    OnBoardingView()
}
