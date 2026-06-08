import Foundation

final class AuthService: AuthServiceProtocol {


    func signInWithGoogle() async throws {

        try await Task.sleep(nanoseconds: 1_000_000_000)

        let token = "mock_access_token_from_google_supabase"

        KeychainManager.shared.save(
            key: "access_token",
            value: token
        )
    }

    func signOut() async throws {

        SessionManager.shared.logout()
    }
}
