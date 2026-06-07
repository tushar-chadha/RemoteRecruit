import Foundation

final class AuthService: AuthServiceProtocol {
    
    // MARK: - Auth Actions
    
    func signInWithGoogle() async throws {
        // TODO: Implement Supabase Google Sign In here.
        // E.g., let session = try await supabase.auth.signInWithOAuth(provider: .google)
        
        // Simulating network delay for now
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Simulated token
        let token = "mock_access_token_from_google_supabase"
        
        KeychainManager.shared.save(
            key: "access_token",
            value: token
        )
    }
    
    func signOut() async throws {
        // TODO: Implement Supabase Sign Out here.
        // try await supabase.auth.signOut()
        
        SessionManager.shared.logout()
    }
}
