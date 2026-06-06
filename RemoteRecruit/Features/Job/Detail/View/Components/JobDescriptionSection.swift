//
//  JobDescriptionSection.swift
//  RemoteRecruit
//
//  Created by tushar on 07/06/26.
//

import SwiftUI

struct JobDescriptionSection: View {
    let job : Job
    var body: some View {

          VStack(alignment: .leading, spacing: 16) {
              SectionTitle(title: "About the Role")
                  .font(.title2.bold())
              Text(job.description.htmlToString)
                  .font(.body)
                  .foregroundStyle(.secondary)
                  .lineSpacing(6)

          }

      }
}

#Preview {
    JobDescriptionSection(job: .mock)
}
