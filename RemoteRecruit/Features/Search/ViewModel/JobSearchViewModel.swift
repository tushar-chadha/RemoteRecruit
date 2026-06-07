import Foundation
import Combine

@MainActor
final class JobSearchViewModel: ObservableObject {
    
    @Published var searchText: String = "" {
        didSet { debouncedSearch() }
    }
    @Published private(set) var searchResults: [Job] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var hasSearched: Bool = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var recentSearches: [String] = [] // ✅ added

    private let jobService: JobServiceProtocol
    private var searchTask: Task<Void, Never>?

    init(jobService: JobServiceProtocol = JobService()) {
        self.jobService = jobService
        self.recentSearches = SearchHistoryManager.shared.getSearches() // ✅ load on init
    }

    private func debouncedSearch() {
        searchTask?.cancel()

        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            searchResults = []
            hasSearched = false
            return
        }

        searchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
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
            searchResults = response.jobs
            SearchHistoryManager.shared.save(search: searchText)
            recentSearches = SearchHistoryManager.shared.getSearches() // ✅ sync after save
        } catch is CancellationError {
            return // ✅ silent cancel
        } catch let urlError as URLError where urlError.code == .cancelled {
            return // ✅ silent URLSession cancel
        } catch {
            errorMessage = error.localizedDescription
            searchResults = []
        }

        isLoading = false
    }

    func selectRecentSearch(_ query: String) {
        searchText = query
    }

    func clearHistory() {
        SearchHistoryManager.shared.clearSearches()
        recentSearches = [] // ✅ triggers UI update immediately
    }
}
