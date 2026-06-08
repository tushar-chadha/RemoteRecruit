import Foundation
@testable import RemoteRecruit

final class MockJobService: JobServiceProtocol {
    var shouldFail: Bool = false
    var mockJobs: [Job] = []
    var fetchCallCount: Int = 0
    var searchCallCount: Int = 0

    func fetchJobs(offset: Int, limit: Int) async throws -> JobResponse {
        fetchCallCount += 1
        if shouldFail {
            throw AppError.network("Mock network failure")
        }
        return JobResponse(
            limit: limit,
            offset: offset,
            totalCount: mockJobs.count,
            jobs: mockJobs,
            updatedAt: Int(Date().timeIntervalSince1970)
        )
    }

    func searchJobs(query: String, page: Int) async throws -> JobResponse {
        searchCallCount += 1
        if shouldFail {
            throw AppError.network("Mock search failure")
        }
        return JobResponse(
            limit: 20,
            offset: (page - 1) * 20,
            totalCount: mockJobs.count,
            jobs: mockJobs,
            updatedAt: Int(Date().timeIntervalSince1970)
        )
    }
}
