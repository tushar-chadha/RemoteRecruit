import SwiftUI
import Combine
struct RootView: View {

    @StateObject
    private var session = SessionManager.shared

    var body: some View {
        Group {
            switch session.authState {
            case .loading:
                SplashView()
            case .authenticated, .guest:   // ✅ merge identical cases
                MainTabView()
            case .unauthenticated:
                AuthView()
            }
        }
        .environmentObject(session)        // ✅ pass session down to all child views
        .onAppear {
            session.checkSession()
        }
        .animation(.easeInOut, value: session.authState) // ✅ smooth state transitions
    }
}
