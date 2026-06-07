//
//  RemoteRecruitApp.swift
//  RemoteRecruit
//
//  Created by tushar on 05/06/26.
//

import SwiftUI

@main
struct RemoteRecruitApp: App {
    @AppStorage("appearanceMode") var appearanceMode: String = "system"
    @StateObject private var sessionManager = SessionManager.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(sessionManager)
                .preferredColorScheme(resolvedScheme)
        }
    }

    private var resolvedScheme: ColorScheme? {
        switch appearanceMode {
        case "light": return .light
        case "dark":  return .dark
        default:      return nil // system
        }
    }
}

}
