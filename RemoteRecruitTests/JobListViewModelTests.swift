import XCTest
import Combine
@testable import RemoteRecruit

final class MockJobService: JobServiceProtocol {
    var shouldThrowError = false
    var mockJobs: [Job] = []
    
    // For pagination testing
    var fetchJobsCallCount = 0
    var lastOffset = 0
    
    // For search testing
    var searchJobsCallCount = 0
    var lastQuery = ""
    
    func fetchJobs(offset: Int, limit: Int) async throws -> JobResponse {
        fetchJobsCallCount += 1
        lastOffset = offset
        
        if shouldThrowError {
            throw AppError.network("Mock network error")
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
        searchJobsCallCount += 1
        lastQuery = query
        
        if shouldThrowError {
            throw AppError.network("Mock search error")
        }
        
        return JobResponse(
            limit: 20,
            offset: 0,
            totalCount: mockJobs.count,
            jobs: mockJobs,
            updatedAt: Int(Date().timeIntervalSince1970)
        )
    }
}

@MainActor
final class JobListViewModelTests: XCTestCase {
    
    private var viewModel: JobListViewModel!
    private var mockService: MockJobService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockService = MockJobService()
        viewModel = JobListViewModel(jobService: mockService)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables = nil
        super.tearDown()
    }
    
    private func createMockJob(id: String = UUID().uuidString) -> Job {
        return Job(
            id: id,
            title: "Software Engineer",
            companyName: "Tech Corp",
            companyLogo: nil,
            employmentType: "Full Time",
            description: "A great job",
            excerpt: "Great job excerpt",
            applicationLink: "https://example.com",
            pubDate: Int(Date().timeIntervalSince1970),
            expiryDate: Int(Date().timeIntervalSince1970) + 86400,
            minSalary: 100000,
            maxSalary: 150000,
            currency: "USD",
            locationRestrictions: ["Remote"],
            companySlug: "tech-corp"
        )
    }
    
    // MARK: - Initial Load Tests
    
    func testLoadJobs_Success() async {
        // Given
        let expectedJobs = [createMockJob(), createMockJob()]
        mockService.mockJobs = expectedJobs
        
        // When
        await viewModel.loadJobs()
        
        // Then
        XCTAssertEqual(mockService.fetchJobsCallCount, 1)
        XCTAssertEqual(mockService.lastOffset, 0)
        
        guard case .loaded(let jobs) = viewModel.state else {
            XCTFail("Expected state to be .loaded, got \(viewModel.state)")
            return
        }
        
        XCTAssertEqual(jobs.count, 2)
        XCTAssertEqual(jobs.first?.title, "Software Engineer")
    }
    
    func testLoadJobs_EmptyState() async {
        // Given
        mockService.mockJobs = []
        
        // When
        await viewModel.loadJobs()
        
        // Then
        guard case .empty(let reason) = viewModel.state else {
            XCTFail("Expected state to be .empty, got \(viewModel.state)")
            return
        }
        
        XCTAssertEqual(reason, .firstLaunch)
    }
    
    func testLoadJobs_ErrorState() async {
        // Given
        mockService.shouldThrowError = true
        
        // When
        await viewModel.loadJobs()
        
        // Then
        guard case .error(let error) = viewModel.state else {
            XCTFail("Expected state to be .error, got \(viewModel.state)")
            return
        }
        
        XCTAssertEqual(error.localizedDescription, "Mock network error")
    }
    
    // MARK: - Pagination Tests
    
    func testLoadMore_Success() async {
        // Given - First load
        let initialJobs = Array(repeating: createMockJob(), count: 20) // Assuming pageSize is 20
        mockService.mockJobs = initialJobs
        await viewModel.loadJobs()
        
        // Setup for pagination
        let nextJobs = [createMockJob()]
        mockService.mockJobs = nextJobs
        
        // When
        await viewModel.loadMore()
        
        // Then
        XCTAssertEqual(mockService.fetchJobsCallCount, 2)
        XCTAssertEqual(mockService.lastOffset, 20) // Should offset by previous count
        
        guard case .loaded(let jobs) = viewModel.state else {
            XCTFail("Expected state to be .loaded, got \(viewModel.state)")
            return
        }
        
        XCTAssertEqual(jobs.count, 21) // 20 + 1
    }
    
    func testLoadMore_WhenCannotLoadMore() async {
        // Given - Load less than page size (20)
        let initialJobs = [createMockJob()]
        mockService.mockJobs = initialJobs
        await viewModel.loadJobs()
        
        let initialCallCount = mockService.fetchJobsCallCount
        
        // When
        await viewModel.loadMore()
        
        // Then
        XCTAssertEqual(mockService.fetchJobsCallCount, initialCallCount, "Should not call fetch if canLoadMore is false")
        
        guard case .loaded(let jobs) = viewModel.state else {
            XCTFail("Expected state to be .loaded")
            return
        }
        
        XCTAssertEqual(jobs.count, 1)
    }
    
    // MARK: - Search Tests
    
    func testDebouncedSearch_Success() async throws {
        // Given
        let searchResultJobs = [createMockJob()]
        mockService.mockJobs = searchResultJobs
        
        // When
        viewModel.searchText = "SwiftUI" // Triggers debouncedSearch via didSet
        
        // Wait for debounce (400ms) + buffer
        try await Task.sleep(nanoseconds: 500_000_000)
        
        // Then
        XCTAssertEqual(mockService.searchJobsCallCount, 1)
        XCTAssertEqual(mockService.lastQuery, "SwiftUI")
        
        guard case .loaded(let jobs) = viewModel.state else {
            XCTFail("Expected state to be .loaded, got \(viewModel.state)")
            return
        }
        
        XCTAssertEqual(jobs.count, 1)
    }
    
    func testDebouncedSearch_EmptyQuery_CallsRefresh() async throws {
        // Given
        mockService.mockJobs = [createMockJob()]
        await viewModel.loadJobs() // Initial load
        
        let fetchCountBeforeClear = mockService.fetchJobsCallCount
        
        // When
        viewModel.searchText = "" // Triggers early exit in debounce, calling refresh
        
        // Wait for async task to complete
        try await Task.sleep(nanoseconds: 100_000_000)
        
        // Then
        XCTAssertEqual(mockService.searchJobsCallCount, 0, "Should not call search")
        XCTAssertEqual(mockService.fetchJobsCallCount, fetchCountBeforeClear + 1, "Should call fetchJobs via refresh")
    }
    
    func testDebouncedSearch_Cancellation() async throws {
        // Given
        mockService.mockJobs = [createMockJob()]
        
        // When
        viewModel.searchText = "Swift"
        viewModel.searchText = "SwiftUI" // This should cancel the first "Swift" search task
        
        // Wait for debounce (400ms) + buffer
        try await Task.sleep(nanoseconds: 500_000_000)
        
        // Then
        XCTAssertEqual(mockService.searchJobsCallCount, 1, "Only the second search should execute")
        XCTAssertEqual(mockService.lastQuery, "SwiftUI")
    }
}
