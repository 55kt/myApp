import SwiftUI

class OTPViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var phoneNumber = ""
    @Published var code = ""
}
