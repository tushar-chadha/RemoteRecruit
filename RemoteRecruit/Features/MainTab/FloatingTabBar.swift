import SwiftUI

struct FloatingTabBar: View {
    let onJobsTap: () -> Void
    let onSavedTap: () -> Void
    let onProfileTap: () -> Void
    let onSearchTap: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            tabButton(icon: "briefcase.fill", text: "Jobs", isSelected: true, action: onJobsTap)
            tabButton(icon: "heart.fill", text: "Saved", isSelected: false, action: onSavedTap)
            tabButton(icon: "person.fill", text: "Profile", isSelected: false, action: onProfileTap)
            tabButton(icon: "magnifyingglass", text: "Search", isSelected: false, action: onSearchTap)
        }
        .padding(.horizontal, AppSpacing.sm)
        .padding(.vertical, AppSpacing.sm)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .shadow(color: AppShadow.floating, radius: 16, y: 8)
        .padding(.horizontal, AppSpacing.md)
    }

    private func tabButton(icon: String, text: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            action()
        }) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                Text(text)
                    .font(AppTypography.caption)
            }
            .foregroundStyle(isSelected ? AppColors.primary : AppColors.textSecondary)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    FloatingTabBar(onJobsTap: {}, onSavedTap: {}, onProfileTap: {}, onSearchTap: {})
}
