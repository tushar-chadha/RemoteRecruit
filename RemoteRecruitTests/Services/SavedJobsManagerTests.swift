import XCTest
@testable import RemoteRecruit

@MainActor
final class SavedJobsManagerTests: XCTestCase {
    var sut: SavedJobsManager!

    override func setUp() {
        super.setUp()
        sut = SavedJobsManager.shared
        sut.clearAll()
    }

    override func tearDown() {
        sut.clearAll()
        sut = nil
        super.tearDown()
    }

    func test_toggleSave_addsJob() {
        let job = Job.mock

        sut.toggleSave(job)

        XCTAssertTrue(sut.isSaved(job))
        XCTAssertEqual(sut.savedJobs.count, 1)
    }

    func test_toggleSave_twice_removesJob() {
        let job = Job.mock
        sut.toggleSave(job)

        sut.toggleSave(job)

        XCTAssertFalse(sut.isSaved(job))
        XCTAssertEqual(sut.savedJobs.count, 0)
    }

    func test_persistence_loadsSavedJobs() {
        let job = Job.mock
        sut.toggleSave(job)

        sut.load()

        XCTAssertTrue(sut.isSaved(job))
        XCTAssertEqual(sut.savedJobs.count, 1)
    }

    func test_clearAll_emptiesSavedJobsAndUserDefaults() {
        let job = Job.mock
        sut.toggleSave(job)

        sut.clearAll()

        XCTAssertEqual(sut.savedJobs.count, 0)
        XCTAssertFalse(sut.isSaved(job))

        sut.load()
        XCTAssertEqual(sut.savedJobs.count, 0)
    }
}
