
import SwiftUI

struct JobRowView: View {
    let job: Job
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: AppSpacing.xs
        ) {
            Text(job.title)
                .font(AppTypography.bodyMedium)
                .foregroundStyle(AppColors.textPrimary)
            
            Text(job.companyDisplayName)
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textPrimary)
            
            HStack(alignment: .firstTextBaseline) {
                Label(job.locationText, systemImage: "location")
                Spacer()
                Text(job.salaryText)
            }
            .font(AppTypography.caption)
            .foregroundStyle(AppColors.textSecondary)
        }
        .padding(.vertical, AppSpacing.xs)
    }
}

