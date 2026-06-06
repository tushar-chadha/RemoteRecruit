//
//  JobRequirementsSection.swift
//  RemoteRecruit
//
//  Created by tushar on 07/06/26.
//

import SwiftUI

struct JobRequirementsSection: View {
    let job: Job
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionTitle(title: "Requirements")
                .font(.title2.bold())
            ForEach(JobParser.requirements(from: job.description), id: \.self) {
                item in
                HStack(alignment: .top) {

                    Circle()

                        .fill(.blue)

                        .frame(width: 8, height: 8)

                        .padding(.top, 6)

                    Text(item)

                        .font(.body)

                }
            }
        }
    }
}

#Preview {
    JobRequirementsSection(job: .mock)
}
