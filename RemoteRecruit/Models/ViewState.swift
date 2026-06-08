
import Foundation

enum ViewState<T: Equatable>: Equatable {
    case idle
    case loading
    case loaded(T)
    case empty(reason: EmptyReason)
    case error(AppError)
    case offline
}
enum AuthState : Equatable{
    case loading
    case authenticated
    case guest
    case unauthenticated
}
enum EmptyReason: Equatable {
    case firstLaunch
    case noResults(query: String)
    case filtered
}

enum AppError: Error, Equatable {
    case network(String)
    case serverError(Int)
    case decodingFailed(String)
    case rateLimited
    case unknown(String)

    var localizedDescription: String {
        switch self {
        case .network(let message):
            return message

        case .serverError(let code):
            return "Server error (\(code))"

        case .decodingFailed:
            return "Failed to parse server response"

        case .rateLimited:
            return "Too many requests"

        case .unknown(let message):
            return message
        }
    }
}
