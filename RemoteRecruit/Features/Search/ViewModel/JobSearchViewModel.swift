import Foundation
import Combine

@MainActor
final class JobSearchViewModel: ObservableObject {
    
    @Published var searchText: String = "" {
        didSet { debouncedSearch() }
    }
    @Published private(set) var searchResults: [Job] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isLoadingMore: Bool = false
    @Published private(set) var hasSearched: Bool = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var recentSearches: [String] = []

    private let jobService: JobServiceProtocol
    private var searchTask: Task<Void, Never>?
    
    private var currentPage = 1
    private var canLoadMore = true

    init(jobService: JobServiceProtocol = JobService()) {
        self.jobService = jobService
        self.recentSearches = SearchHistoryManager.shared.getSearches()
    }

    private func debouncedSearch() {
        searchTask?.cancel()

        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            searchResults = []
            hasSearched = false
            currentPage = 1
            canLoadMore = true
            return
        }

        searchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            guard !Task.isCancelled else { return }
            currentPage = 1
            canLoadMore = true
            searchResults = []
            await performSearch()
        }
    }

    func performSearch() async {
        isLoading = true
        errorMessage = nil
        hasSearched = true

        do {
            let response = try await jobService.searchJobs(query: searchText, page: currentPage)
            searchResults = response.jobs
            
            if !response.jobs.isEmpty && searchText.trimmingCharacters(in: .whitespaces).count >= 3 {
                SearchHistoryManager.shared.save(search: searchText)
                recentSearches = SearchHistoryManager.shared.getSearches()
            }
            
            canLoadMore = !response.jobs.isEmpty
        } catch is CancellationError {
            return
        } catch let urlError as URLError where urlError.code == .cancelled {
            return
        } catch {
            errorMessage = error.localizedDescription
            searchResults = []
        }

        isLoading = false
    }

    func loadMoreIfNeeded(currentJob: Job) async {
        guard let last = searchResults.last, last.id == currentJob.id else { return }
        guard canLoadMore, !isLoadingMore else { return }
        
        currentPage += 1
        isLoadingMore = true
        do {
            let response = try await jobService.searchJobs(query: searchText, page: currentPage)
            
            let existingIDs = Set(searchResults.map { $0.id })
            let newJobs = response.jobs.filter { !existingIDs.contains($0.id) }
            
            searchResults.append(contentsOf: newJobs)
            canLoadMore = !response.jobs.isEmpty
        } catch is CancellationError {
            return
        } catch let urlError as URLError where urlError.code == .cancelled {
            return
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoadingMore = false
    }

    func selectRecentSearch(_ query: String) {
        searchText = query
    }

    func clearHistory() {
        SearchHistoryManager.shared.clearSearches()
        recentSearches = []
    }
}
