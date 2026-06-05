//
//  JobService.swift
//  RemoteRecruit
//
//  Created by tushar on 06/06/26.
//

import Foundation


final class JobService: JobServiceProtocol {
    private let networkService: NetworkService
    private let baseURL = "https://himalayas.app/jobs/api"

    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    func fetchJobs(offset Offset: Int, limit: Int) async throws -> JobResponse {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(Offset)),
        ]

        guard let url = components?.url else {
            throw AppError.unknown("Invalid URL")
        }
        return try await networkService.request(from: url)
    }
    func searchJobs(query: String, page: Int) async throws -> JobResponse {
          var components = URLComponents(string: baseURL + "/search")
          components?.queryItems = [
              URLQueryItem(name: "q", value: query),
              URLQueryItem(name: "page", value: String(page))
          ]
          
          guard let url = components?.url else { throw AppError.unknown("Invalid URL") }
          return try await networkService.request(from: url)
      }

}
