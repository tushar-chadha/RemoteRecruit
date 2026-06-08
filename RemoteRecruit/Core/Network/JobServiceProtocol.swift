
import Foundation

protocol JobServiceProtocol: AnyObject {

    func fetchJobs(
        offset: Int,
        limit: Int
    ) async throws -> JobResponse

    func searchJobs(
        query: String,
        page: Int
    ) async throws -> JobResponse
}
