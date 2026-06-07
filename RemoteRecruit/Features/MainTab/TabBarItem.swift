import SwiftUI

enum TabBarItem: String, CaseIterable {
    case jobs = "Jobs"
    case saved = "Saved"
    case profile = "Profile"
    
    var iconName: String {
        switch self {
        case .jobs: return "briefcase.fill"
        case .saved: return "heart.fill"
        case .profile: return "person.fill"
        }
    }
}
