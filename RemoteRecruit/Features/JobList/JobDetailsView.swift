//
//  JobDetailsView.swift
//  RemoteRecruit
//
//  Created by tushar on 06/06/26.
//

import SwiftUI

struct JobDetailView: View {

    let job: Job

    var body: some View {

        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(job.title)
                    .font(.largeTitle)
                    .bold()
                Text(job.companyDisplayName)
                    .font(.title3)
                Text(job.locationText)
                Text(job.salaryText)
                Divider()
                Text(job.description.htmlToString)
            }
            .padding()
        }
        .navigationTitle("Job Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
