import SwiftUI

struct ContinueButtonView: View {
    @Binding var activePage: Page

    var body: some View {
        if activePage == .page4 {
            NavigationLink(destination: OTPPhoneNumberInputView()) {
                buttonContent
            }
        } else {
            Button {
                activePage = activePage.nextPage
            } label: {
                buttonContent
            }
        }
    }

    private var buttonContent: some View {
        Text(activePage == .page4 ? "Login to ChatMe App" : "Continue")
            .foregroundColor(.black)
            .font(.system(size: 20, weight: .medium))
            .padding(.vertical, 18)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding()
    }
}
