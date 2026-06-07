//
//  JobListViewModel.swift
//  RemoteRecruit
//
//  Created by tushar on 06/06/26.
//

import Combine
//Load jobs
//Store jobs
//Handle pagination
//Handle errors
//Handle loading
//Handle empty states
/*
 Architechture
 JobListView
       ↓
 JobListViewModel
       ↓
 JobServiceProtocol
       ↓
 JobService
       ↓
 NetworkService*/
import Foundation

@MainActor
final class JobListViewModel: ObservableObject {
    // MARK: - Dependencies
    private let jobService: JobServiceProtocol

    // MARK: - Published State
    @Published private(set) var state: ViewState<[Job]> = .idle
    @Published var searchText = "" {
        didSet {
            debouncedSearch(query: searchText)
        }
    }
    @Published var recentSearches: [String] = []

    // MARK: - Search
    private var searchTask: Task<Void, Never>?
    private var isSearchMode = false
    var isSearching : Bool{
        searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty==false 
    }
    // MARK: - Pagination
    private var jobs: [Job] = []
    private var currentOffset = 0
    private let pageSize = 20
    private var canLoadMore = true
    // MARK: - Init
    init(
        jobService: JobServiceProtocol
    ) {
        self.jobService = jobService
    }
    // MARK: - Initial Load

    func loadJobs() async {
        guard state != .loading else { return }
        state = .loading

        do {
            let response = try await jobService.fetchJobs(
                offset: currentOffset,
                limit: pageSize
            )
            for job in response.jobs.prefix(5) {
                print(job.companyName)
            }
            jobs = response.jobs
            currentOffset = jobs.count
            canLoadMore = response.jobs.count == pageSize
            if jobs.isEmpty {
                state = .empty(reason: .firstLaunch)
            } else {
                state = .loaded(jobs)
            }
        } catch {
            state = .error(

                .unknown(error.localizedDescription)

            )
        }
    }
    // MARK: - Pagination
    func loadMore() async {
        guard canLoadMore else {
            return
        }
        guard case .loaded = state else {
            return
        }
        do {
            let response = try await jobService.fetchJobs(
                offset: currentOffset,
                limit: pageSize
            )

            jobs.append(contentsOf: response.jobs)
            currentOffset += response.jobs.count
            canLoadMore = response.jobs.count == pageSize
            state = .loaded(jobs)
        } catch let error as AppError {
            state = .error(error)
        } catch {
            state = .error(
                .unknown(error.localizedDescription)
            )
        }
    }
    // MARK: - Refresh

    func refresh() async {
        currentOffset = 0
        canLoadMore = true
        jobs.removeAll()
        await loadJobs()
    }

    // MARK: - Debounced Search
    func debouncedSearch(query: String) {
        searchTask?.cancel()

        if query.isEmpty {
            Task { await refresh() }
            return  // ✅ Exit early — don't create a search task
        }

        searchTask = Task {
            try? await Task.sleep(for: .milliseconds(400))
            guard !Task.isCancelled else { return }  // ✅ Readable: "ensure NOT canceled"
            await performSearch(query: query)
        }
    }
    private func performSearch(
        query: String
    ) async {
        print("Searching: \(query)")
        state = .loading
        do {
            let response = try await jobService.searchJobs(
                query: query,
                page: 1
            )
            print(response)
            print("Searching: \(query)")
            print("Jobs Found: \(response.jobs.count)")
            jobs = response.jobs

            if jobs.isEmpty {
                state = .empty(
                    reason: .noResults(
                        query: query
                    )
                )
            } else {
                SearchHistoryManager.shared.save(
                    search: searchText
                )
                loadRecentSearches()
                state = .loaded(jobs)
            }
        } catch is CancellationError {
            return
        } catch let urlError as URLError where urlError.code == .cancelled {
            return
        } catch let error as AppError {
            if case .unknown(let msg) = error,
                msg.lowercased().contains("cancel")
            {
                return
            }
            print("Apperror is: \(error)")
            state = .error(error)
        } catch {
            print("error is: \(error)")
            state = .error(
                .unknown(error.localizedDescription)
            )
        }

        // MARK: - RECENT SEARCH KEYWORDS

    }
    func loadRecentSearches() {
        recentSearches =
            SearchHistoryManager.shared.getSearches()
    }
}
