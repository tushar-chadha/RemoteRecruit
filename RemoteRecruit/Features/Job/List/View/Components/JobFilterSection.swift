import SwiftUI

struct JobFilterSection: View {
    let filters = ["Remote", "Full Time", "iOS", "Swift", "SwiftUI", "Mid Level", "Senior"]
    @State private var selectedFilter: String = "Remote"

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppSpacing.xs) {
                ForEach(filters, id: \.self) { filter in
                    Button(action: {
                        withAnimation {
                            selectedFilter = filter
                        }
                    }) {
                        Text(filter)
                            .font(AppTypography.bodyMedium)
                            .padding(.horizontal, AppSpacing.sm)
                            .padding(.vertical, AppSpacing.xs)
                            .background(selectedFilter == filter ? AppColors.primary : AppColors.secondaryBackground)
                            .foregroundStyle(selectedFilter == filter ? Color.white : AppColors.primary)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal, AppSpacing.md)
        }
        .padding(.horizontal, -AppSpacing.md)
    }
}

#Preview {
    JobFilterSection()
}
