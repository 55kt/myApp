//
//  IntroView.swift
//  TalkToMe
//
//  Created by Vlad on 29/7/24.
//

import SwiftUI

struct IntroView: View {
    // MARK: - Properties
    @State private var activePage: Page = .page1
    
    // MARK: - Body
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack {
                Spacer(minLength: 0)
                
                MorphingSymbolView(
                    symbol: activePage.rawValue,
                    config: .init(
                        font: .system(size: 150, weight: .bold),
                        frame: .init(width: 250, height: 200),
                        radius: 30,
                        foregroundColor: .white
                    )
                )
                tabViewContents(size: size)
                
                Spacer(minLength: 0)
                
                indicatorView()
                
                if activePage == .page4 {
                    continueButton()
                }
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .top) {
                headerView()
            }
        }
        .background {
            Rectangle()
                .fill(.black.gradient)
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func headerView() -> some View {
        HStack {
            Button {
                activePage = activePage.previousPage
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .contentShape(.rect)
                    .foregroundStyle(.white)
                    .padding()
            }
            .opacity(activePage != .page1 ? 1 : 0)
            
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
    
    @ViewBuilder
        func tabViewContents(size: CGSize) -> some View {
            TabView(selection: $activePage) {
                ForEach(Page.allCases, id: \.rawValue) { page in
                    VStack(spacing: 8) {
                        Text(page.title)
                            .lineLimit(1)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .kerning(1.1)
                            .frame(width: size.width, alignment: .center)
                        
                        Text(page.subTitle)
                            .font(.callout)
                            .foregroundStyle(.gray)
                            .frame(width: size.width)
                            .multilineTextAlignment(.center)
                    }
                    .tag(page)
                    .padding(.top, 15)
                    .frame(width: size.width, alignment: .leading)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.smooth(duration: 0.9, extraBounce: 0.1), value: activePage)
            .frame(height: 110)
            .padding(.bottom)
        }
    
    @ViewBuilder
    func indicatorView() -> some View {
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
    
    // Continue button
    @ViewBuilder
    func continueButton() -> some View {
        Button {
            activePage = activePage.nextPage
        } label: {
            Text(activePage == .page4 ? "Login into ps App" : "Continue")
                .foregroundStyle(.black)
                .padding(.vertical, 15)
                .frame(maxWidth: activePage == .page1 ? 220 : 180)
                .background(.white, in: .capsule)
        }
        .padding(.bottom, 15)
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
}
