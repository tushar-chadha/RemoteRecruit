import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabBarItem = .jobs
    @State private var isSearchPresented: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Main Content
            TabView(selection: $selectedTab) {
                JobListView()
                    .tag(TabBarItem.jobs)
                    // Hiding default tab bar
                    .toolbar(.hidden, for: .tabBar)
                
                SavedJobsView()
                    .tag(TabBarItem.saved)
                    .toolbar(.hidden, for: .tabBar)
                
                ProfileView()
                    .tag(TabBarItem.profile)
                    .toolbar(.hidden, for: .tabBar)
            }
            
            // Custom Floating Tab Bar
            FloatingTabBar(selectedTab: $selectedTab, searchAction: {
                isSearchPresented = true
            })
            .padding(.bottom, AppSpacing.sm)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .sheet(isPresented: $isSearchPresented) {
            JobSearchView()
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(SessionManager.shared)
}
