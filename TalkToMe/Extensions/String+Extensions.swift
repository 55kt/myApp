import Foundation

// Extension for spaces and newlines
extension String {
    var isEmptyOrWhitespace: Bool { return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
}
 
