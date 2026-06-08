
import SwiftUI

struct JobInfoCard: View {
    let title: String
    let value: String
    let icon: String
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(AppColors.primary)

            Text(title)
                .font(AppTypography.caption)
                .foregroundStyle(AppColors.textSecondary)

            Text(value)
                .font(AppTypography.bodyMedium)
                .foregroundStyle(AppColors.textPrimary)
                .multilineTextAlignment(.leading)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppSpacing.sm)
        .frame(height: 140)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
        .shadow(
            color: AppShadow.card,
            radius: 10,
            y: 5
        )
    }
}

#Preview {
    JobInfoCard(title: "title", value: "value", icon: "")
}
