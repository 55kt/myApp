//
//  UserAvatar.swift
//  TalkToMe
//
//  Created by Vlad on 6/8/24.
//

import SwiftUI

struct UserAvatar: View {
    @Binding var boolPlaceholder: Bool
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .padding()
                    .scaledToFit()
                    .frame(width: boolPlaceholder ? 300 : 190, height: boolPlaceholder ? 300 : 190)
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    .shadow(radius: 10)
                
                
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: boolPlaceholder ? 180 : 100, height: boolPlaceholder ? 180 : 100)
            }
        }
        .padding(.bottom, boolPlaceholder ? 200 : 160)
    }
}
