import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool { return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
}
 
