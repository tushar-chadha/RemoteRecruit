import Combine
import Foundation

final class SavedJobsManager: ObservableObject {
    static let shared = SavedJobsManager()

    @Published private(set) var savedJobs: [Job] = []

    private let storageKey = "saved_jobs"

    private init() {
        load()
    }

    func toggleSave(_ job: Job) {
        if isSaved(job) {
            savedJobs.removeAll { $0.id == job.id }
        } else {
            savedJobs.append(job)
        }
        persist()
    }

    func isSaved(_ job: Job) -> Bool {
        savedJobs.contains { $0.id == job.id }
    }

    private func persist() {
        if let encoded = try? JSONEncoder().encode(savedJobs) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
            let decoded = try? JSONDecoder().decode([Job].self, from: data)
        {
            savedJobs = decoded
        }
    }
}
