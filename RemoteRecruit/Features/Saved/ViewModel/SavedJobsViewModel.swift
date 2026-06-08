import Foundation
import Combine

@MainActor
final class SavedJobsViewModel: ObservableObject {
    @Published private(set) var savedJobs: [Job] = []

    private let manager = SavedJobsManager.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        manager.$savedJobs
            .receive(on: RunLoop.main)
            .sink { [weak self] jobs in
                self?.savedJobs = jobs
            }
            .store(in: &cancellables)
    }

    func loadSavedJobs() {
        self.savedJobs = manager.savedJobs
    }
}
