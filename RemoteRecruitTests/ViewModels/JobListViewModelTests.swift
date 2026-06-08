import XCTest
@testable import RemoteRecruit

@MainActor
final class JobListViewModelTests: XCTestCase {
    var sut: JobListViewModel!
    var mockService: MockJobService!

    override func setUp() {
        super.setUp()
        mockService = MockJobService()
        sut = JobListViewModel(jobService: mockService)
    }

    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }

    func test_loadJobs_success_setsLoadedState() async {
        mockService.mockJobs = [.mock]

        await sut.loadJobs()

        if case .loaded(let jobs) = sut.state {
            XCTAssertEqual(jobs.count, 1)
            XCTAssertEqual(jobs.first?.id, Job.mock.id)
        } else {
            XCTFail("Expected .loaded state, got \(sut.state)")
        }
    }

    func test_loadJobs_empty_setsEmptyState() async {
        mockService.mockJobs = []

        await sut.loadJobs()

        if case .empty(let reason) = sut.state {
            XCTAssertEqual(reason, .firstLaunch)
        } else {
            XCTFail("Expected .empty state, got \(sut.state)")
        }
    }

    func test_loadJobs_failure_setsErrorState() async {
        mockService.shouldFail = true

        await sut.loadJobs()

        if case .error(let error) = sut.state {
            XCTAssertNotNil(error)
        } else {
            XCTFail("Expected .error state, got \(sut.state)")
        }
    }

    func test_loadMore_appendsJobsAndIncrementsOffset() async {
        // Given
        let initialJobs = (0..<20).map { i in
            Job(
                id: "job_\(i)",
                title: "Job \(i)",
                companyName: "Company",
                companyLogo: nil,
                employmentType: nil,
                description: "",
                excerpt: nil,
                applicationLink: nil,
                pubDate: nil,
                expiryDate: nil,
                minSalary: nil,
                maxSalary: nil,
                currency: nil,
                locationRestrictions: nil,
                companySlug: nil
            )
        }
        mockService.mockJobs = initialJobs
        await sut.loadJobs()

        let nextJob = Job(
            id: "job_20",
            title: "Job 20",
            companyName: "Company",
            companyLogo: nil,
            employmentType: nil,
            description: "",
            excerpt: nil,
            applicationLink: nil,
            pubDate: nil,
            expiryDate: nil,
            minSalary: nil,
            maxSalary: nil,
            currency: nil,
            locationRestrictions: nil,
            companySlug: nil
        )
        mockService.mockJobs = [nextJob]

        // When
        await sut.loadMore()

        // Then
        if case .loaded(let jobs) = sut.state {
            XCTAssertEqual(jobs.count, 21)
            XCTAssertEqual(mockService.fetchCallCount, 2)
        } else {
            XCTFail("Expected .loaded state, got \(sut.state)")
        }
    }
}
