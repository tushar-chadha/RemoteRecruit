import SwiftUI

struct JobCardView: View {
    let job: Job

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {

            HStack {
                CompanyLogo(urlString: job.companyLogo)
                VStack(alignment: .leading, ) {
                    Text(job.title)
                        .font(AppTypography.bodyMedium.bold())
                        .foregroundStyle(AppColors.textPrimary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 4)
                        .padding(.bottom, 0.2)
                    HStack(spacing: 4) {
                        Text(job.companyDisplayName)
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColors.textPrimary)

                        Text("•")
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColors.textSecondary)

                        Text(job.locationText)
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColors.textSecondary)
                            .lineLimit(1)
                    }
                }

                Spacer()
                SaveButton(job: job)

            }

            if let types = job.employmentType, !types.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: AppSpacing.xs) {
                        TagCapsule(text: types.capitalized)
                    }
                }
            }

            Divider()
                .background(AppColors.border)
                .padding(.vertical, 1)

            HStack(alignment: .lastTextBaseline) {
                Text(job.salaryText)
                    .font(AppTypography.bodyMedium)
                    .foregroundStyle(AppColors.primary)

                Spacer()

                Text(job.postedDateText)
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.textSecondary)
            }
        }
        .padding(AppSpacing.sm)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.extraLarge))
        .shadow(color: AppShadow.card, radius: 16, y: 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            "\(job.title) at \(job.companyDisplayName), \(job.locationText)"
        )
        .accessibilityHint("Double tap to view job details")
    }
}

#Preview {
    JobCardView(job: .mock)
}
