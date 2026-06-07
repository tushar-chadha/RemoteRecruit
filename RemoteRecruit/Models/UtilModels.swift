//
//  UtilModels.swift
//  RemoteRecruit
//
//  Created by tushar on 07/06/26.
//

internal import UIKit

extension String {

    var htmlToString: String {
        // NSAttributedString HTML parsing is extremely slow and MUST happen on the main thread.
        // Calling it synchronously inside a SwiftUI view body evaluating multiple times causes AttributeGraph cycles.
        // For production, this should ideally be parsed once in the ViewModel or Model init.
        // For immediate safety, we strip basic HTML tags manually to avoid the NSAttributedString crash loop.
        var stripped = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        stripped = stripped.replacingOccurrences(of: "&nbsp;", with: " ")
        stripped = stripped.replacingOccurrences(of: "&amp;", with: " ")
        return stripped.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}


enum keyChainKeys: String {
    case accessToken = "access_token"
}
