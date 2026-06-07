import SwiftUI

struct FloatingTabBar: View {
    @Binding var selectedTab: TabBarItem
    let searchAction: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabBarItem.allCases, id: \.self) { tab in
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tab.iconName)
                            .font(.system(size: 20, weight: .medium))
                        Text(tab.rawValue)
                            .font(AppTypography.caption)
                    }
                    .foregroundStyle(selectedTab == tab ? AppColors.primary : AppColors.textSecondary)
                    .frame(maxWidth: .infinity)
                }
            }
            
            // Search Button
            Button(action: {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                searchAction()
            }) {
                VStack(spacing: 4) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20, weight: .medium))
                    Text("Search")
                        .font(AppTypography.caption)
                }
                .foregroundStyle(AppColors.textSecondary)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, AppSpacing.sm)
        .padding(.vertical, AppSpacing.sm)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .shadow(color: AppShadow.floating, radius: 16, y: 8)
        .padding(.horizontal, AppSpacing.md)
    }
}

#Preview {
    FloatingTabBar(selectedTab: .constant(.jobs), searchAction: {})
}
