import Combine
import Foundation

@MainActor
final class JobListViewModel: ObservableObject {
    private let jobService: JobServiceProtocol

    @Published private(set) var state: ViewState<[Job]> = .idle
    @Published var searchText = "" {
        didSet {
            debouncedSearch(query: searchText)
        }
    }
    @Published var recentSearches: [String] = []
    @Published private(set) var isLoadingMore: Bool = false

    private var searchTask: Task<Void, Never>?
    var isSearching: Bool {
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var jobs: [Job] = []
    private var currentOffset = 0
    private let pageSize = 20
    private var canLoadMore = true

    private var searchPage = 1
    private var canLoadMoreSearchResults = true

    init(jobService: JobServiceProtocol) {
        self.jobService = jobService
    }

    func loadJobs() async {
        guard state != .loading else { return }
        state = .loading

        do {
            let response = try await jobService.fetchJobs(
                offset: currentOffset,
                limit: pageSize
            )
            jobs = response.jobs
            currentOffset = jobs.count
            canLoadMore = response.jobs.count == pageSize
            if jobs.isEmpty {
                state = .empty(reason: .firstLaunch)
            } else {
                state = .loaded(jobs)
            }
        } catch {
            state = .error(.unknown(error.localizedDescription))
        }
    }

    func loadMore() async {
        guard canLoadMore, !isLoadingMore else { return }
        guard case .loaded = state else { return }
        
        isLoadingMore = true
        do {
            let response = try await jobService.fetchJobs(
                offset: currentOffset,
                limit: pageSize
            )

            let existingIDs = Set(jobs.map { $0.id })
            let newJobs = response.jobs.filter { !existingIDs.contains($0.id) }
            
            jobs.append(contentsOf: newJobs)
            currentOffset += response.jobs.count
            canLoadMore = response.jobs.count == pageSize
            state = .loaded(jobs)
        } catch let error as AppError {
            state = .error(error)
        } catch {
            state = .error(.unknown(error.localizedDescription))
        }
        isLoadingMore = false
    }

    func loadMoreIfNeeded(currentJob: Job) async {
        guard let last = jobs.last, last.id == currentJob.id else { return }
        if isSearching {
            await loadMoreSearchSearchResults()
        } else {
            await loadMore()
        }
    }

    func refresh() async {
        currentOffset = 0
        canLoadMore = true
        jobs.removeAll()
        await loadJobs()
    }

    func debouncedSearch(query: String) {
        searchTask?.cancel()

        if query.isEmpty {
            Task { await refresh() }
            return
        }

        searchTask = Task {
            try? await Task.sleep(for: .milliseconds(400))
            guard !Task.isCancelled else { return }
            await performSearch(query: query)
        }
    }

    private func performSearch(query: String) async {
        state = .loading
        searchPage = 1
        canLoadMoreSearchResults = true
        
        do {
            let response = try await jobService.searchJobs(
                query: query,
                page: searchPage
            )
            jobs = response.jobs

            if jobs.isEmpty {
                state = .empty(reason: .noResults(query: query))
            } else {
                if query.trimmingCharacters(in: .whitespaces).count >= 3 {
                    SearchHistoryManager.shared.save(search: query)
                    loadRecentSearches()
                }
                state = .loaded(jobs)
                canLoadMoreSearchResults = response.jobs.count == pageSize
            }
        } catch is CancellationError {
            return
        } catch let urlError as URLError where urlError.code == .cancelled {
            return
        } catch let error as AppError {
            state = .error(error)
        } catch {
            state = .error(.unknown(error.localizedDescription))
        }
    }

    func loadMoreSearchSearchResults() async {
        guard canLoadMoreSearchResults, !isLoadingMore else { return }
        
        isLoadingMore = true
        searchPage += 1
        do {
            let response = try await jobService.searchJobs(
                query: searchText,
                page: searchPage
            )
            
            let existingIDs = Set(jobs.map { $0.id })
            let newJobs = response.jobs.filter { !existingIDs.contains($0.id) }
            
            jobs.append(contentsOf: newJobs)
            canLoadMoreSearchResults = response.jobs.count == pageSize
            state = .loaded(jobs)
        } catch is CancellationError {
            // silent
        } catch let urlError as URLError where urlError.code == .cancelled {
            // silent
        } catch {
            state = .error(.unknown(error.localizedDescription))
        }
        isLoadingMore = false
    }

    func loadRecentSearches() {
        recentSearches = SearchHistoryManager.shared.getSearches()
    }
}
