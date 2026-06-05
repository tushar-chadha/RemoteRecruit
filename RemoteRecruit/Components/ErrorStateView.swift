//
//  ErrorStateView.swift
//  RemoteRecruit
//
//  Created by tushar on 06/06/26.
//

//
// ErrorStateView.swift
//

import SwiftUI

struct ErrorStateView: View {

    let message: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
            Text(message)
            Button(
                "Retry",
                action: retryAction
            )
        }
    }
}
