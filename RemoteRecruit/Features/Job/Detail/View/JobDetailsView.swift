
import SwiftUI

struct JobDetailView: View {

    let job: Job

    var body: some View {

        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
             
                    JobHeroSection(job: job)
                    JobInfoCardsSection(job: job)
                    JobDescriptionSection(job: job)
                    Divider()
                    JobRequirementsSection(job: job)

                    CompanySection(job: job)
                }
                .padding(16)
                .padding(.bottom, 80)
            }

            ApplyBottomBar(job: job)
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(
            AppColors.background
                .ignoresSafeArea()
        )
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                CircleButton(icon: "square.and.arrow.up") {
                    shareJob()
                }
                SaveButton(job: job)
            }
        }
    }

    private func shareJob() {
        guard let link = job.applicationLink, let url = URL(string: link) else { return }

        let text = "Check out this job: \(job.title) at \(job.companyDisplayName)"
        let activityVC = UIActivityViewController(activityItems: [text, url], applicationActivities: nil)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
}

#Preview {
    JobDetailView(job: .mock)
}
