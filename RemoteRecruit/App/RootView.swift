import SwiftUI

struct RootView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        Group {
            switch sessionManager.authState {
            case .loading:
                SplashView()
                    .transition(.opacity)
            case .authenticated, .guest:
                JobListView()
                    .transition(.opacity)
            case .unauthenticated:
                AuthView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: sessionManager.authState)
    }
}

#Preview {
    RootView()
        .environmentObject(SessionManager.shared)
}
