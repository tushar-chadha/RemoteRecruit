import Foundation

protocol AuthServiceProtocol {
    func signInWithGoogle() async throws
    func signOut() async throws
}
