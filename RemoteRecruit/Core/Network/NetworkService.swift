//
//  NetworkService.swift
//  RemoteRecruit
//
//  Created by tushar on 06/06/26.
//

import Foundation

final class NetworkService {

    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session

    }
    func request<T: Decodable>(from url: URL, ) async throws -> T {
        var request = URLRequest(url: url)
        request.timeoutInterval = 15.00
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let data: Data
        let response: URLResponse

        do { (data, response) = try await session.data(for: request) } catch let
            error as URLError
        {
            throw AppError.unknown(error.localizedDescription)  // We will map specific URLErrors later
        } catch {
            if error is CancellationError { throw error }
            throw AppError.unknown(error.localizedDescription)
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AppError.unknown("Invalid Server Response")
        }
        switch httpResponse.statusCode {
        case 200...299: break
        case 429: throw AppError.rateLimited
        case 500...599:
            throw AppError.serverError(httpResponse.statusCode)
        default: throw AppError.serverError( httpResponse.statusCode)
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw AppError.decodingFailed(error.localizedDescription)
        }
    }
}
