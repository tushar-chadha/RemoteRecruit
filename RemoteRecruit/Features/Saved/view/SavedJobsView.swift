import SwiftUI

struct SavedJobsView: View {
    @StateObject private var manager = SavedJobsManager.shared

    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.background.ignoresSafeArea()

                if manager.savedJobs.isEmpty {
                    emptyState
                } else {
                    ScrollView {
                        LazyVStack(spacing: AppSpacing.md) {
                            ForEach(manager.savedJobs) { job in
                                NavigationLink(destination: JobDetailView(job: job)) {
                                    JobCardView(job: job)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(AppSpacing.md)
                        .padding(.bottom, 80)
                    }
                }
            }
            .navigationTitle("Saved Jobs")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: AppSpacing.sm) {
            Image(systemName: "heart.slash")
                .font(.system(size: 60))
                .foregroundStyle(AppColors.textSecondary)
                .padding(.bottom, AppSpacing.sm)

            Text("No Saved Jobs")
                .font(AppTypography.section)
                .foregroundStyle(AppColors.textPrimary)

            Text("Jobs you save will appear here.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    SavedJobsView()
}
