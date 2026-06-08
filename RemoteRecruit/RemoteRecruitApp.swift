
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
        default:      return nil
        }
    }
}


