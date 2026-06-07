import SwiftUI

struct SaveButton: View {
    let job: Job
    @StateObject private var savedJobsManager = SavedJobsManager.shared
    
    var isSaved: Bool {
        savedJobsManager.isSaved(job: job)
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                savedJobsManager.toggleSave(job: job)
            }
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }) {
            Image(systemName: isSaved ? "heart.fill" : "heart")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(isSaved ? AppColors.primary : AppColors.textSecondary)
                .frame(width: 44, height: 44) // Accessibility minimum touch target
                .contentShape(Circle())
        }
    }
}

