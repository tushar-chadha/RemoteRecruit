import SwiftUI

struct SaveButton: View {
    let job: Job

    @State private var isSaved: Bool

    init(job: Job) {
        self.job = job
        _isSaved = State(initialValue: SavedJobsManager.shared.isSaved(job))
    }

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                SavedJobsManager.shared.toggleSave(job)
                isSaved = SavedJobsManager.shared.isSaved(job)
            }
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }) {
            Image(systemName: isSaved ? "heart.fill" : "heart")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(isSaved ? AppColors.primary : AppColors.textSecondary)
                .frame(width: 44, height: 44)
                .contentShape(Circle())
        }
        .accessibilityLabel(isSaved ? "Remove \(job.title) from saved jobs" : "Save \(job.title)")
        .accessibilityAddTraits(.isButton)
        .accessibilityRemoveTraits(.isImage)
        .onAppear {
            isSaved = SavedJobsManager.shared.isSaved(job)
        }
    }
}
