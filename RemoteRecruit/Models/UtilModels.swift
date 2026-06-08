
internal import UIKit

extension String {

    var htmlToString: String {
        var stripped = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        stripped = stripped.replacingOccurrences(of: "&nbsp;", with: " ")
        stripped = stripped.replacingOccurrences(of: "&amp;", with: " ")
        return stripped.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var cleanedDescription: String {
        self.htmlToString
            .replacingOccurrences(of: "\n\n", with: "\n")
            .replacingOccurrences(of: "Responsibilities:", with: "\n\nResponsibilities:\n")
            .replacingOccurrences(of: "Requirements:", with: "\n\nRequirements:\n")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}


enum keyChainKeys: String {
    case accessToken = "access_token"
}
