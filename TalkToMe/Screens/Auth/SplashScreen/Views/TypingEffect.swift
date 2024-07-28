//
//  TypingEffect.swift
//  TalkToMe
//
//  Created by Vlad on 28/7/24.
//

import SwiftUI

struct TypingEffect: View {
    // MARK: - Properties
    @State private var displayText = ""
    var fullText: String
    @State private var currentCharIndex: String.Index!
    @Binding var isExpended: Bool
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text(displayText)
                .font(.caption2)
                .foregroundStyle(.white)
                .frame(width: 300, height: 150, alignment: .topLeading)
        }
        .onChange(of: isExpended) {oldValue, newValue in
            if newValue {
                startTypingEffect()
            }
        }
    }
    
    func startTypingEffect() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            currentCharIndex = fullText.startIndex
            
            Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                displayText.append(fullText[currentCharIndex])
                currentCharIndex = fullText.index(after: currentCharIndex)
                if currentCharIndex == fullText.endIndex {
                    timer.invalidate()
                }
            }
        }
    }
}
