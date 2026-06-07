import SwiftUI

struct RecentSearchesView: View {

    let searches: [String]
    let onTap: (String) -> Void

    var body: some View {

        if !searches.isEmpty {

            VStack(alignment: .leading, spacing: AppSpacing.sm) {

                Text("Recent Searches")
                    .font(AppTypography.bodyMedium)
                    .foregroundStyle(AppColors.textPrimary)

                ScrollView(.horizontal, showsIndicators: false) {

                    HStack(spacing: AppSpacing.sm) {

                        ForEach(searches, id: \.self) { search in

                            SearchChipView(title: search) {
                                onTap(search)
                            }
                        }
                    }
                }
            }
        }
    }
}
