
import SwiftUI

struct JobDescriptionSection: View {
    let job : Job
    var body: some View {

          VStack(alignment: .leading, spacing: AppSpacing.md) {
              SectionTitle(title: "About the Role")
                  .font(.title2.bold())
              ExpandableText(
                  text: job.description.cleanedDescription,
                  limit: 150
              )
          }

      }
}

#Preview {
    JobDescriptionSection(job: .mock)
}
