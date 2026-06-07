import Foundation
import Combine

enum AuthState {
    case loading
    case authenticated
    case guest
    case unauthenticated
}

@MainActor
final class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published private(set) var authState: AuthState = .loading
    
    private let tokenKey = "access_token"
    private let guestKey = "is_guest"
    
    private init() {
        checkSession()
    }
    
    // MARK: - Session Management
    
    func checkSession() {
        if KeychainManager.shared.get(key: tokenKey) != nil {
            updateAuthState(.authenticated)
        } else if UserDefaults.standard.bool(forKey: guestKey) {
            updateAuthState(.guest)
        } else {
            updateAuthState(.unauthenticated)
        }
    }
    
    func guestMode() {
        UserDefaults.standard.set(true, forKey: guestKey)
        updateAuthState(.guest)
    }
    
    func logout() {
        KeychainManager.shared.delete(key: tokenKey)
        KeychainManager.shared.delete(key: "refresh_token")
        UserDefaults.standard.set(false, forKey: guestKey)
        updateAuthState(.unauthenticated)
    }
    
    // MARK: - State Update
    
    private func updateAuthState(_ state: AuthState) {
        self.authState = state
    }
}
