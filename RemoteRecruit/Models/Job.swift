//
//  Models.swift
//  RemoteRecruit
//
//  Created by tushar on 06/06/26.
//

import Foundation

struct JobResponse: Codable, Equatable {
    let limit: Int
    let offset: Int?  // The search endpoint might not return offset, so we make it optional
    let totalCount: Int
    let jobs: [Job]
    let updatedAt: Int
}
/// The individual job listing model
struct Job: Codable, Identifiable, Hashable, Equatable {
    let id: String
    let title: String
    let companyName: String
    let companyLogo: String?
    let employmentType: String?
    let description: String
    let excerpt: String?
    let applicationLink: String?
    let pubDate: Int // Himalayas uses a UNIX timestamp integer
    let minSalary: Int?
    let maxSalary: Int?
    let currency: String?
    let locationRestrictions: [String]?
    let companySlug: String
    let expiryDate: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "guid"
        case title
        case companyName
        case companyLogo
        case employmentType
        case description
        case excerpt
        case applicationLink
        case pubDate
        case minSalary
        case maxSalary
        case currency
        case locationRestrictions
        case companySlug
        case expiryDate
    }
}
