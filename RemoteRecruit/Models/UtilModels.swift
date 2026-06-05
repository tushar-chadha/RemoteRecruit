//
//  UtilModels.swift
//  RemoteRecruit
//
//  Created by tushar on 07/06/26.
//


internal import UIKit

extension String {

    var htmlToString: String {

        guard let data = data(using: .utf8) else {
            return self
        }

        do {

            let attributed = try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )

            return attributed.string

        } catch {

            return self
        }
    }
}
