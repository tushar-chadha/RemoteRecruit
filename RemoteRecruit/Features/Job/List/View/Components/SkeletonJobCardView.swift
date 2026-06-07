import SwiftUI

struct SkeletonJobCardView: View {
    @State private var animate = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(animate ? 0.15 : 0.3))
                .frame(height: 16)
                .frame(maxWidth: .infinity)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(animate ? 0.15 : 0.3))
                .frame(width: 140, height: 12)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(animate ? 0.15 : 0.3))
                .frame(width: 100, height: 12)
        }
        .padding(AppSpacing.md)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
        .onAppear {
            withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
                animate = true
            }
        }
    }
}

#Preview {
    ZStack {
        AppColors.background.ignoresSafeArea()
        SkeletonJobCardView()
            .padding()
    }
}
