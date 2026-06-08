
import SwiftUI
import Combine
struct CompanySection: View {

    let job: Job

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: AppSpacing.sm
        ) {
            Text("About Company")
                .font(AppTypography.section)
                .foregroundStyle(AppColors.textPrimary)

            HStack(spacing: AppSpacing.sm) {
                AsyncImage(
                    url: URL(string: job.companyLogo ?? "")
                ) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)

                VStack(alignment: .leading) {
                    Text(job.companyDisplayName)
                        .font(AppTypography.bodyMedium)
                        .foregroundStyle(AppColors.textPrimary)
                    
                    if let slug = job.companySlug {
                        Text(slug)
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColors.textSecondary)
                    }
                }

                Spacer()
            }

            if let excerpt = job.excerpt {
                Text(excerpt)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
            }
        }
        .padding(AppSpacing.sm)
        .background(AppColors.cardBackground)
        .clipShape(
            RoundedRectangle(cornerRadius: AppRadius.large)
        )
        .shadow(
            color: AppShadow.card,
            radius: 12,
            y: 4
        )
    }
}
#Preview {
    CompanySection(job: .mock)
}
