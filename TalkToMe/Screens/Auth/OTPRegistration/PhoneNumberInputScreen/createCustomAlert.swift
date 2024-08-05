//
//  CustomAlertView.swift
//  TalkToMe
//
//  Created by Vlad on 4/8/24.
//

import SwiftUI

func createCustomAlert(title: String, message: String, primaryButtonText: String, secondaryButtonText: String, primaryAction: @escaping () -> Void, secondaryAction: @escaping () -> Void) -> Alert {
    return Alert(
        title: Text(title),
        message: Text(message),
        primaryButton: .default(Text(primaryButtonText), action: primaryAction),
        secondaryButton: .cancel(Text(secondaryButtonText), action: secondaryAction)
    )
}
