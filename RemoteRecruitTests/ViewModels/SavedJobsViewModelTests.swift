import XCTest
import Combine
@testable import RemoteRecruit

@MainActor
final class SavedJobsViewModelTests: XCTestCase {
    var sut: SavedJobsViewModel!
    var manager: SavedJobsManager!

    override func setUp() {
        super.setUp()
        manager = SavedJobsManager.shared
        manager.clearAll()
        sut = SavedJobsViewModel()
    }

    override func tearDown() {
        sut = nil
        manager.clearAll()
        manager = nil
        super.tearDown()
    }

    func test_loadSavedJobs_syncsWithManager() {
        let job = Job.mock
        manager.toggleSave(job)

        sut.loadSavedJobs()

        XCTAssertEqual(sut.savedJobs.count, 1)
        XCTAssertEqual(sut.savedJobs.first?.id, job.id)
    }
}
