import Foundation
import Combine

@MainActor
final class SavedJobsViewModel: ObservableObject {
    @Published private(set) var savedJobs: [Job] = []
    @Published var isLoading: Bool = false
    
    private let jobService: JobServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(jobService: JobServiceProtocol = JobService()) {
        self.jobService = jobService
        
        // Listen for changes in SavedJobsManager
        SavedJobsManager.shared.$savedJobIDs
            .sink { [weak self] _ in
                Task {
                    await self?.fetchSavedJobs()
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchSavedJobs() async {
        let ids = SavedJobsManager.shared.savedJobIDs
        
        guard !ids.isEmpty else {
            savedJobs = []
            return
        }
        
        isLoading = true
        
        do {
            // Ideally the API supports fetching multiple jobs by ID
            // For now, we simulate fetching them if the API doesn't have a batch endpoint.
            // In a real scenario: let response = try await jobService.fetchJobs(ids: Array(ids))
            
            // Simulating by fetching recent and filtering
            let response = try await jobService.fetchJobs(offset: 0, limit: 100)
            self.savedJobs = response.jobs.filter { ids.contains($0.id) }
        } catch {
            print("Failed to fetch saved jobs: \(error)")
        }
        
        isLoading = false
    }
}
