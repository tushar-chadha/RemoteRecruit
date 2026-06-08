
import Foundation
import SwiftUI
import Combine
@MainActor
final class AppEnvironment {

    let jobService: JobServiceProtocol

    init(
        jobService: JobServiceProtocol = JobService()
    ) {
        self.jobService = jobService
    }
}
