import Foundation

@MainActor
final class JobSearchViewModel: ObservableObject {
    @Published var searchText: String = "" {
        didSet {
            debouncedSearch()
        }
    }
    @Published private(set) var searchResults: [Job] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var hasSearched: Bool = false
    @Published private(set) var errorMessage: String?
    
    private let jobService: JobServiceProtocol
    private var searchTask: Task<Void, Never>?
    
    init(jobService: JobServiceProtocol = JobService()) {
        self.jobService = jobService
    }
    
    private func debouncedSearch() {
        searchTask?.cancel()
        
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            searchResults = []
            hasSearched = false
            return
        }
        
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5s debounce
            guard !Task.isCancelled else { return }
            await performSearch()
        }
    }
    
    private func performSearch() async {
        isLoading = true
        errorMessage = nil
        hasSearched = true
        
        do {
            let response = try await jobService.searchJobs(query: searchText, page: 1)
            self.searchResults = response.jobs
            // Save to history
            SearchHistoryManager.shared.addSearch(searchText)
        } catch {
            self.errorMessage = error.localizedDescription
            self.searchResults = []
        }
        
        isLoading = false
    }
    
    func selectRecentSearch(_ query: String) {
        searchText = query
    }
    
    func clearHistory() {
        SearchHistoryManager.shared.clearHistory()
    }
}
