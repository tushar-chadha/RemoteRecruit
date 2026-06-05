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
}
