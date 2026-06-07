import SwiftUI

struct JobCardView: View {
    let job: Job
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            // Top Row: Logo & Save Button
            HStack(alignment: .top) {
                CompanyLogo(urlString: job.companyLogo)
                Spacer()
                SaveButton(job: job)
            }
            
            // Middle: Title
            Text(job.title)
                .font(AppTypography.section)
                .foregroundStyle(AppColors.textPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            // Company Row
            HStack(spacing: AppSpacing.xs) {
                Text(job.companyDisplayName)
                    .font(AppTypography.bodyMedium)
                    .foregroundStyle(AppColors.textPrimary)
                
                Text("•")
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.textSecondary)
                
                Text(job.locationText)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(1)
            }
            
            // Tags Row
            if let types = job.employmentType, !types.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: AppSpacing.xs) {
                        TagCapsule(text: types.capitalized)
                        // Note: Depending on parsing, we can extract more tags
                    }
                }
            }
            
            Divider()
                .background(AppColors.border)
                .padding(.vertical, 4)
            
            // Bottom Row: Salary & Posted Date
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
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
        .shadow(color: AppShadow.card, radius: 12, y: 4)
    }
}
