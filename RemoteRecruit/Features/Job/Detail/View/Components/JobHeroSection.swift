
import SwiftUI

struct JobHeroSection: View {
    let job: Job
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            companyLogo
            VStack(alignment: .leading, spacing: AppSpacing.xs,) {
                Text(job.title)
                    .font(AppTypography.title)
                    .foregroundStyle(AppColors.textPrimary)
                    .multilineTextAlignment(.leading)

                HStack(spacing: AppSpacing.xs) {
                    Text(job.companyDisplayName)
                    Circle()
                        .frame(width: 4)
                    Text(job.locationText)
                }
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
            }

            HStack(spacing: AppSpacing.xs) {
                if let type = job.employmentType {
                    JobTag(text: type)
                }

                JobTag(text: "Remote")
            }
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.top, AppSpacing.md)
    }
}
extension JobHeroSection {
    fileprivate var companyLogo: some View {
        AsyncImage(url: URL(string: job.companyLogo ?? "")) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Image(systemName: "building.2.fill")
                .font(.largeTitle)
                .foregroundStyle(AppColors.textSecondary)
        }
        .frame(width: 72, height: 72)
        .background(AppColors.cardBackground)
        .clipShape(
            RoundedRectangle(
                cornerRadius: AppRadius.medium
            )
        )
        .shadow(
            color: AppShadow.card,
            radius: 12,
            y: 6
        )
    }
}
#Preview {
    JobHeroSection(job: .mock)
}
