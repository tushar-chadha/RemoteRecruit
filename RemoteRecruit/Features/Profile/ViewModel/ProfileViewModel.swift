import Foundation
import Combine
@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var isGuest: Bool = false
    @Published private(set) var userEmail: String? = nil
    @Published private(set) var userName: String? = nil

    private let sessionManager = SessionManager.shared

    init() {
        updateProfileState()
    }

    func updateProfileState() {
        if sessionManager.authState == .guest {
            isGuest = true
        } else if sessionManager.authState == .authenticated {
            isGuest = false
            userEmail = "developer@remoterecruit.com"
            userName = "Remote Developer"
        }
    }

    func logout() {
        sessionManager.logout()
    }

    func loginFromGuest() {
        sessionManager.logout()
    }
}
