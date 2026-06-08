import XCTest
@testable import RemoteRecruit

@MainActor
final class JobSearchViewModelTests: XCTestCase {
    var sut: JobSearchViewModel!
    var mockService: MockJobService!

    override func setUp() {
        super.setUp()
        mockService = MockJobService()
        sut = JobSearchViewModel(jobService: mockService)
    }

    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }

    func test_performSearch_success_updatesResultsAndHasSearched() async {
        mockService.mockJobs = [.mock]
        sut.searchText = "iOS"

        await sut.performSearch()

        XCTAssertEqual(sut.searchResults.count, 1)
        XCTAssertTrue(sut.hasSearched)
        XCTAssertNil(sut.errorMessage)
    }

    func test_performSearch_failure_setsErrorMessage() async {
        mockService.shouldFail = true
        sut.searchText = "iOS"

        await sut.performSearch()

        XCTAssertEqual(sut.searchResults.count, 0)
        XCTAssertNotNil(sut.errorMessage)
    }

    func test_emptySearchText_clearsResults() {
        sut.searchText = "iOS"

        sut.searchText = ""

        XCTAssertEqual(sut.searchResults.count, 0)
        XCTAssertFalse(sut.hasSearched)
    }

    func test_selectRecentSearch_updatesSearchText() {
        sut.selectRecentSearch("Swift")

        XCTAssertEqual(sut.searchText, "Swift")
    }

    func test_clearHistory_emptiesRecentSearches() {
        SearchHistoryManager.shared.save(search: "iOS")
        sut.clearHistory()

        XCTAssertTrue(sut.recentSearches.isEmpty)
    }
}
