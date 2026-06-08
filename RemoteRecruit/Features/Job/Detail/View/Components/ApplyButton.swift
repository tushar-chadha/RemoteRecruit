import SwiftUI
import Combine
struct ApplyBottomBar: View {

    let job: Job

    var body: some View {
        Group {
            if let linkString = job.applicationLink, let url = URL(string: linkString) {
                Link(destination: url) {
                    Text("Apply Now")
                        .font(AppTypography.bodyMedium)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(AppColors.primary)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
                .accessibilityLabel("Apply for \(job.title) at \(job.companyDisplayName)")
                .accessibilityHint("Opens application page")
            } else {
                Button(action: {}) {
                    Text("Apply Not Available")
                        .font(AppTypography.bodyMedium)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(AppColors.textSecondary)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
                .disabled(true)
            }
        }
        .padding(.horizontal, AppSpacing.md)
        .padding(.bottom, AppSpacing.md)
    }
}
