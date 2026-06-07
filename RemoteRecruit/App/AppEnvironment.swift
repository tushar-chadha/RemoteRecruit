//
//  AppEnvironment.swift
//  RemoteRecruit
//
//  Created by tushar on 06/06/26.
//

import Foundation
import SwiftUI
import Combine
/// Dependency Container managing shared state and platform tracking instances.
@MainActor
final class AppEnvironment {

    let jobService: JobServiceProtocol

    init(
        jobService: JobServiceProtocol = JobService()
    ) {
        self.jobService = jobService
    }
}
