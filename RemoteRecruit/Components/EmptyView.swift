//
//  EmptyView.swift
//  RemoteRecruit
//
//  Created by tushar on 06/06/26.
//

//
// EmptyStateView.swift
//

import SwiftUI

struct EmptyStateView: View {

    let title: String
    let message: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray")
            Text(title)
                .font(.headline)
            Text(message)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
    }
}
