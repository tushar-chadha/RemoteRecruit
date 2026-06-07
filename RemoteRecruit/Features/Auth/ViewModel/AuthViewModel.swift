import Foundation
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    // MARK: - Dependencies
    private let authService: AuthServiceProtocol
    
    // MARK: - Initialization
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    // MARK: - Actions
    
    func signInWithGoogle() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await authService.signInWithGoogle()
            // SessionManager handles the state update if keychain is populated successfully,
            // or we could force a check here if needed.
            SessionManager.shared.checkSession()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func continueAsGuest() {
        SessionManager.shared.guestMode()
    }
}
