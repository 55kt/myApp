//
//  OTPLoginViewModel.swift
//  TalkToMe
//
//  Created by Vlad on 27/7/24.
//

import SwiftUI

class OTPViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var phoneNumber = ""
    @Published var code = ""
    
    // MARK: - Functions
    
    func getCountryCode() -> String {
        
        let regionCode = Locale.current.region?.identifier ?? ""
        
        return countries[regionCode] ?? ""
    }
}
