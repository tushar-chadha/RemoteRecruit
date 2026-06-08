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
            case .authenticated, .guest:
                JobListView()
            case .unauthenticated:
                AuthView()
            }
        }
        .environmentObject(session)
        .onAppear {
            session.checkSession()
        }
        .animation(.easeInOut, value: session.authState)
    }
}
