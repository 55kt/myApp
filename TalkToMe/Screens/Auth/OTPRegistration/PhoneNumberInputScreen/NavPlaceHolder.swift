//
//  NavPlaceHolder.swift
//  TalkToMe
//
//  Created by Vlad on 2/8/24.
//

import SwiftUI

struct NavPlaceHolder: View {
    var body: some View {
        VStack {
            Text("Continue with your phone number")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding()
            
            Image(systemName: "platter.filled.top.and.arrow.up.iphone")
                .resizable()
                .frame(width: 100, height: 160)
                .foregroundStyle(.white)
            
            
            Text("You`ll receive a 6 digit code\n to verify next")
                .font(.title2)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding()
        }
        .shadow(radius: 10)
    }
}
