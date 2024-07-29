//
//  FirstOnBoardingView.swift
//  TalkToMe
//
//  Created by Vlad on 28/7/24.
//

import SwiftUI

struct FirstOnBoardingView: View {
    // MARK: - Properties
    @Binding var showNextView: Bool
    @State private var isExpanded: Bool = false
    @State private var startType: Bool = false
    @State private var showText: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                
                AnimatedView(isExpanded: $isExpanded, startType: $startType, showText: $showText, color: LinearGradient(colors: [.yellow, .orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing), image: "")
                
                VStack(alignment: .leading) {
                    Text("lorem ipsum \n0ndolor")
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
}

#Preview {
    FirstOnBoardingView(showNextView: .constant(true))
}

struct AnimatedView: View {
    // MARK: - Properties
    @Binding var isExpanded: Bool
    @Binding var startType: Bool
    @Binding var showText: Bool
    
    var color: LinearGradient
    var image: String
    var text: String = "NEXT"
    var showNextView: Binding<Bool>?
    var showToggleExpanded: Bool = true
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(image).resizable()
                    .frame(width: isExpanded ? max(geometry.size.width, geometry.size.height) * 1.5 : 200, height: isExpanded ? max(geometry.size.width, geometry.size.height) * 1.5 : 200)
                    .mask(Circle())
                Circle().fill(color)
                    .frame(width: isExpanded ? max(geometry.size.width, geometry.size.height) * 1.5 : 200, height: isExpanded ? max(geometry.size.width, geometry.size.height) * 1.5 : 200)
                
                if !isExpanded {
                    HStack {
                        Text(text).foregroundStyle(.white)
                        Image(systemName: "arrow.right")
                    }
                    .bold()
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .offset(x: isExpanded ? -250 : 40, y: isExpanded ? -150 : 20)
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.9, dampingFraction: 0.8)) {
                if showToggleExpanded {
                    isExpanded.toggle()
                } else {
                    isExpanded = true
                }
                
                showText.toggle()
                startType = true
                
                if let showNextViewBinding = showNextView {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showNextViewBinding.wrappedValue.toggle()
                    }
                }
            }
        }
    }
}
