//
//  SearchHistoryManager.swift
//  RemoteRecruit
//
//  Created by tushar on 07/06/26.
//

import Foundation

final class SearchHistoryManager {
    static let shared = SearchHistoryManager()
    private let key = historyManagerKeys.recentSearch

    func save(search: String) {

        var searches = getSearches()

        searches.removeAll {
            $0.lowercased() == search.lowercased()
        }

        searches.insert(search, at: 0)
        searches = Array(searches.prefix(10))
        UserDefaults.standard.set(searches, forKey: key.rawValue)
    }
    func getSearches() -> [String] {
        let searches =
            UserDefaults.standard.stringArray(
                forKey: key.rawValue
            ) ?? []
        print("━━━━━━━━━━━━━━━━━━━━")
        print("📚 RECENT SEARCHES")
        print("Count: \(searches.count)")

        searches.enumerated().forEach {
            index,
            value in
            print("\(index + 1). \(value)")
        }
        print("━━━━━━━━━━━━━━━━━━━━")
        return searches
    }

    func clearSearches() {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
enum historyManagerKeys: String {
    case recentSearch = "recent_searches"
}
