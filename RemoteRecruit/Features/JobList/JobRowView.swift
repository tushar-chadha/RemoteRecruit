//
//  JobRowView.swift
//  RemoteRecruit
//
//  Created by tushar on 06/06/26.
//
//
// JobRowView.swift
//

import SwiftUI

struct JobRowView: View {
    let job: Job
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            Text(job.title)
                .font(.headline)
            Text(job.companyDisplayName)
                .font(.subheadline)
            //            Text(job.locationRestrictions.description.description)
            //                .font(.caption)
            HStack(alignment: .firstTextBaseline) {
                Label(job.locationText, systemImage: "location")
                Spacer()
                Text(job.salaryText)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical,8)
    }
}

