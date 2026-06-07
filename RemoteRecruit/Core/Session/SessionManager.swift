import Foundation
import Combine

final class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published var isLoggedIn: Bool = false
    
    private let tokenKey = "access_token"
    
    private init() {
        checkSession()
    }
    
    func checkSession() {
        if KeychainManager.shared.get(key: tokenKey) != nil {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }
    
    func saveSession(token: String) {
        KeychainManager.shared.set(key: tokenKey, value: token)
        isLoggedIn = true
    }
    
    func logout() {
        KeychainManager.shared.delete(key: tokenKey)
        isLoggedIn = false
    }
    
    func deleteAccount() {
        KeychainManager.shared.clearAll()
        isLoggedIn = false
    }
}
