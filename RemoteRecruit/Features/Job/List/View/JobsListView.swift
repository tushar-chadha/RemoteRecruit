import Foundation
import SwiftUI

struct JobListView: View {
    @StateObject private var viewModel: JobListViewModel
    @State private var isSearching = false
    
    // MARK: - Navigation States
    @State private var showSaved = false
    @State private var showProfile = false
    @State private var showSearch = false
    @State private var selectedSearchQuery = ""

    init() {
        let service = JobService()
        _viewModel = StateObject(
            wrappedValue: JobListViewModel(
                jobService: service
            )
        )
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ZStack {
                    AppColors.background.ignoresSafeArea()

                    content
                }
                
                // Custom Floating Tab Bar overlay
                FloatingTabBar(
                    onJobsTap: {
                        // Action for current screen, e.g., scroll to top
                    },
                    onSavedTap: {
                        showSaved = true
                    },
                    onProfileTap: {
                        showProfile = true
                    },
                    onSearchTap: {
                        selectedSearchQuery = ""
                        showSearch = true
                    }
                )
                .padding(.bottom, AppSpacing.sm)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationTitle("Find Your Dream Job")
            .navigationBarTitleDisplayMode(.large)
            .task {
                viewModel.loadRecentSearches()
                await viewModel.loadJobs()
            }
            // MARK: - Navigation Destinations
            .navigationDestination(isPresented: $showSaved) {
                SavedJobsView()
            }
            .navigationDestination(isPresented: $showProfile) {
                ProfileView()
            }
            .sheet(isPresented: $showSearch) {
                JobSearchView(initialQuery: selectedSearchQuery)
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            Color.clear  // Should transition quickly to loading

        case .loading:
            ScrollView {
                LazyVStack(spacing: AppSpacing.md) {
                    ForEach(0..<6, id: \.self) { _ in
                        SkeletonJobCardView()
                    }
                }
                .padding(AppSpacing.md)
                .padding(.bottom, 80) // Padding for FloatingTabBar
            }

        case .empty:
            emptyStateView

        case .error(let error):
            errorStateView(error: error)

        case .loaded(let jobs):
            loadedStateView(jobs: jobs)

        case .offline:
            EmptyStateView(
                title: "Offline",
                message: "Please check your internet connection"
            )
        }
    }

    @ViewBuilder
    private func loadedStateView(jobs: [Job]) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                if !isSearching {
                    RecentSearchesView(
                        searches: viewModel.recentSearches
                    ) { search in
                        selectedSearchQuery = search
                        showSearch = true
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Text("\(jobs.count) Jobs Found")
                            .font(AppTypography.section)
                        Spacer()
                        Text("Updated just now")
                            .font(AppTypography.caption)
                            .foregroundStyle(
                                AppColors.textSecondary
                            )
                    }
                }

                // Jobs List
                LazyVStack(spacing: AppSpacing.md) {
                    ForEach(jobs) { job in
                        NavigationLink(destination: JobDetailView(job: job)) {
                            JobCardView(job: job)
                        }
                        .buttonStyle(.plain)  // Remove default NavigationLink styling
                    }

                    // Loading indicator for pagination could go here
                }
            }
            .padding(.horizontal, AppSpacing.md)
            .padding(.bottom, 100) // Padding for FloatingTabBar
        }
        .refreshable {
            await viewModel.refresh()
        }
    }

    // MARK: - Subviews
    private var emptyStateView: some View {
        VStack(spacing: AppSpacing.sm) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundStyle(AppColors.textSecondary)
                .padding(.bottom, AppSpacing.sm)

            Text("No Jobs Found")
                .font(AppTypography.section)
                .foregroundStyle(AppColors.textPrimary)

            Text("Try adjusting your search filters")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)

            Button("Reset Filters") {
                viewModel.searchText = ""
                Task {
                    await viewModel.refresh()
                }
            }
            .font(AppTypography.bodyMedium)
            .foregroundStyle(Color.white)
            .padding(.horizontal, AppSpacing.md)
            .padding(.vertical, AppSpacing.xs)
            .background(AppColors.primary)
            .clipShape(Capsule())
            .padding(.top, AppSpacing.sm)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func errorStateView(error: Error) -> some View {
        VStack(spacing: AppSpacing.sm) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundStyle(AppColors.error)

            Text("Something went wrong")
                .font(AppTypography.section)

            Text(error.localizedDescription)
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)

            Button("Try Again") {
                Task {
                    await viewModel.loadJobs()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(AppColors.primary)
            .padding(.top, AppSpacing.md)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    JobListView()
}
