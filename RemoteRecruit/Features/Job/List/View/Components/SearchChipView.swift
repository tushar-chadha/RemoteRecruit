import SwiftUI

struct SearchChipView: View {

    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppTypography.caption)
                .foregroundStyle(AppColors.primary)
                .padding(.horizontal, AppSpacing.md)
                .padding(.vertical, AppSpacing.xs)
                .background(AppColors.chipBackground)
                .clipShape(Capsule())
        }
    }
}

#Preview {
    SearchChipView(title: "SwiftUI") { }
}
