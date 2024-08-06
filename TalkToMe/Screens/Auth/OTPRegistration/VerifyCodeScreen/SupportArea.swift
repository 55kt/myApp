//
//  SupportArea.swift
//  TalkToMe
//
//  Created by Vlad on 6/8/24.
//

import SwiftUI

struct SupportArea: View {
    var body: some View {
        HStack(spacing: 6) {
            Text("Didn't receive code?")
                .foregroundStyle(.white)
            
            Button {
                // Some action
            } label: {
                Text("Request again")
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
            }
            
            
        }
        
        Button {
            // Some action
        } label: {
            Text("Get via call")
                .fontWeight(.bold)
                .foregroundStyle(.blue)
        }
        .padding(.top, 6)
    }
}

#Preview {
    SupportArea()
}
