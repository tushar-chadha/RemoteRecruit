
import SwiftUI

struct JobRequirementsSection: View {
    let job: Job

    private var requirements: [String] {
        JobParser.requirements(from: job.description)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            SectionTitle(title: "Requirements")
                .font(.title2.bold())

            ExpandableText(
                text: requirements.map { "• \($0)" }.joined(separator: "\n"),
                limit: 150
            )
        }
    }
}

#Preview {
    JobRequirementsSection(job: .mock)
}
