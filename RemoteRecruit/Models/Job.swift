//
//  Models.swift
//  RemoteRecruit
//
//  Created by tushar on 06/06/26.
//
import Foundation
internal import UIKit

struct JobResponse: Codable, Equatable {
    let limit: Int
    let offset: Int?
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

    let pubDate: Int?
    let expiryDate: Int?

    let minSalary: Double?
    let maxSalary: Double?
    let currency: String?

    let locationRestrictions: [String]?

    let companySlug: String?

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

extension Job {
    var postedDateText: String {
        let date = Date(timeIntervalSince1970: TimeInterval(pubDate ?? 0))
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        
        return formatter.localizedString(
            for: date,
            relativeTo: Date()
        )

    }
    var salaryText: String {

        guard let minSalary, let maxSalary else {
            return "Not Disclosed"
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0

        let min =
            formatter.string(
                from: NSNumber(value: minSalary)
            ) ?? "\(Int(minSalary))"

        let max =
            formatter.string(
                from: NSNumber(value: maxSalary)
            ) ?? "\(Int(maxSalary))"

        let symbol: String

        switch currency {
        case "USD":
            symbol = "$"

        case "EUR":
            symbol = "€"

        case "GBP":
            symbol = "£"

        default:
            symbol = ""
        }

        return "\(symbol)\(min) - \(symbol)\(max)"
    }

    var locationText: String {
        locationRestrictions?.joined(separator: ", ") ?? "Remote"
    }

    var companyDisplayName: String {
        companyName.isEmpty || companyName.lowercased() == "name"
            ? "Not Disclosed"
            : companyName
    }

    var publishedDate: Date? {
        guard let pubDate else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(pubDate))
    }

    var expiry: Date? {
        guard let expiryDate else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(expiryDate))
    }
}

enum JobParser {

    static func requirements(from html: String) -> [String] {

        let text = html.htmlToString

        let lines = text.components(separatedBy: "\n")

        return lines
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter {
                !$0.isEmpty &&
                (
                    $0.contains("Swift") ||
                    $0.contains("iOS") ||
                    $0.contains("experience") ||
                    $0.contains("degree") ||
                    $0.contains("skills")
                )
            }
            .prefix(8)
            .map { $0 }
    }
}
