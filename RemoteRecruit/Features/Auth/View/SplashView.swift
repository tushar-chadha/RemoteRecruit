import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            VStack(spacing: AppSpacing.md) {
                Image(systemName: "globe.desk.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(AppColors.primary)

                Text("RemoteRecruit")
                    .font(AppTypography.title)
                    .foregroundStyle(AppColors.textPrimary)

                ProgressView()
                    .padding(.top, AppSpacing.sm)
            }
        }
    }
}

#Preview {
    SplashView()
}
