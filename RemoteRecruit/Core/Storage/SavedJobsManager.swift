import Foundation
import Combine

@MainActor
final class SavedJobsManager: ObservableObject {
    static let shared = SavedJobsManager()
    
    @Published private(set) var savedJobIDs: Set<String> = []
    
    private let storageKey = "saved_jobs_ids"
    
    private init() {
        loadSavedJobs()
    }
    
    private func loadSavedJobs() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
            savedJobIDs = decoded
        }
    }
    
    private func saveToDisk() {
        if let encoded = try? JSONEncoder().encode(savedJobIDs) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    func save(job: Job) {
        savedJobIDs.insert(job.id)
        saveToDisk()
    }
    
    func remove(job: Job) {
        savedJobIDs.remove(job.id)
        saveToDisk()
    }
    
    func isSaved(job: Job) -> Bool {
        savedJobIDs.contains(job.id)
    }
    
    func toggleSave(job: Job) {
        if isSaved(job: job) {
            remove(job: job)
        } else {
            save(job: job)
        }
    }
}
