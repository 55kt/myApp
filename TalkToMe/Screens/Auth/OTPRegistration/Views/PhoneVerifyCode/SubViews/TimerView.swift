import SwiftUI

struct TimerView: View {
    @State private var timeRemaining = 5 // 2 минуты (120 секунд)
    @State private var timerRunning = true
    @State private var attemptsLeft = 3
    @State private var showResendButton = false
    
    var onTimerEnd: () -> Void
    var onResendCode: () -> Void
    
    var body: some View {
        VStack {
            if timerRunning {
                Text("Resend code in: \(formatTime(timeRemaining))")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .onAppear {
                        startTimer()
                    }
            } else if showResendButton {
                VStack(spacing: 10) {
                    HStack(spacing: 6) {
                        Text("Didn't receive code?")
                            .foregroundStyle(.white)
                        
                        Button(action: {
                            if attemptsLeft > 0 {
                                attemptsLeft -= 1
                                resetTimer()
                                onResendCode()
                            }
                        }) {
                            Text("Request again")
                                .fontWeight(.bold)
                                .foregroundStyle(attemptsLeft > 0 ? Color.mBlueColor : Color.gray)
                        }
                        .disabled(attemptsLeft == 0)
                    }

                    if attemptsLeft > 0 {
                        Text("You have \(attemptsLeft) attempt\(attemptsLeft == 1 ? "" : "s") left")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.7))
                    } else {
                        Text("No attempts left")
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                }
                .padding(.top, 10)
            }
        }
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timerRunning = false
                showResendButton = true
                timer.invalidate()
                onTimerEnd()
            }
        }
    }
    
    private func resetTimer() {
        timeRemaining = 5
        timerRunning = true
        showResendButton = false
        startTimer()
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    TimerView(
        onTimerEnd: {
            print("Timer ended")
        },
        onResendCode: {
            print("Code resent")
        }
    )
}
