//
//  JobInfoCardsSection.swift
//  RemoteRecruit
//
//  Created by tushar on 07/06/26.
//

import SwiftUI

struct JobInfoCard: View {
    let title: String
    let value: String
    let icon: String
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.blue)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.headline)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)

        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .frame(height: 140)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(
                color: .black.opacity(0.05),
                    radius: 10,
                    y: 5
            )
    }
}

#Preview {
    JobInfoCard(title: "title", value: "value", icon: "")
}
