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
    
    var body: some Scene {
        WindowGroup {
            JobListView() // home entry
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
