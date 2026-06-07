import Foundation
import Combine

@MainActor 
final class SavedJobsViewModel: ObservableObject {
    @Published private(set) var savedJobs: [Job] = []
    
    private let manager = SavedJobsManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Subscribe to changes in the manager
        manager.$savedJobs
            .receive(on: RunLoop.main)
            .sink { [weak self] jobs in
                self?.savedJobs = jobs
            }
            .store(in: &cancellables)
    }
    
    func loadSavedJobs() {
        // Since we are observing $savedJobs, we just sync our local state with the manager
        self.savedJobs = manager.savedJobs
    }
}
