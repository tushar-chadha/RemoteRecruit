import Foundation
import Combine
@MainActor
final class AuthViewModel: ObservableObject {

    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }


    func signInWithGoogle() async {
        isLoading = true
        errorMessage = nil

        do {
            try await authService.signInWithGoogle()
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
