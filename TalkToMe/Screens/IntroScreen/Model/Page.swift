//
//  Page.swift
//  TalkToMe
//
//  Created by Vlad on 29/7/24.
//

import SwiftUI

enum Page: String, CaseIterable {
    case page1 = "text.bubble"
    case page2 = "lock.shield"
    case page3 = "gauge.with.dots.needle.67percent"
    case page4 = "person.line.dotted.person.fill"
    
    var title: String {
        switch self {
        case .page1: "Welcome to ChatMe"
        case .page2: "Privacy and Security"
        case .page3: "Speed"
        case .page4: "Connect With People"
        }
    }
    
    var subTitle: String {
        switch self {
        case .page1: "Your Journey starts here"
        case .page2: "Discover a deeper gaming experience\nwith the DualSense controller"
        case .page3: "Stream your PS5 to Mac or\nApple devices"
        case .page4: "Reach out and make new friends"
        }
    }
    
    var index: CGFloat {
        switch self {
        case .page1: 0
        case .page2: 1
        case .page3: 2
        case .page4: 3
        }
    }
    
    // Fetches the next page, if it`s not the last page
    var nextPage: Page {
        let index = Int(self.index) + 1
        if index < 4 {
            return Page.allCases[index]
        }
        return self
    }
    
    // Fetches the previous page, if it`s not the first page
    var previousPage: Page {
        let index = Int(self.index) - 1
        if index >= 0 {
            return Page.allCases[index]
        }
        return self
    }
}
