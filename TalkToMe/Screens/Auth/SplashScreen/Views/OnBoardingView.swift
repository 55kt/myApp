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
    @State private var showView: Bool = false
    @State private var showTextView: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                Text("SwiftUICodes OnBoarding").bold().font(.largeTitle)
                    .offset(y: -50)
                    .multilineTextAlignment(.center)
                
                FirstOnBoardingView(showNextView: $showView)
                
                SecondOnBoardingView(showNextView: $showView).modifier(ViewAnimation(isShow: showView))
                
                StartOnBoardingView(showNextView: $showTextView).modifier(ViewAnimation(isShow: showView))
            }
        }
    }
}

#Preview {
    OnBoardingView()
}
