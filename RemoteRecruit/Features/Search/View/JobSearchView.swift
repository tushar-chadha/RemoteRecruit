import SwiftUI

struct JobSearchView: View {
    var initialQuery: String = ""
    @StateObject private var viewModel = JobSearchViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()

                if viewModel.isLoading {
                    ProgressView()

                } else if viewModel.hasSearched {

                    if viewModel.searchResults.isEmpty {
                        emptyState
                    } else {
                        resultsList
                    }

                } else {
                    recentSearches
                }
            }
            .navigationTitle("Search Jobs")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Job title, keyword, or company"
            )
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .task {
                guard !initialQuery.isEmpty else { return }
                viewModel.searchText = initialQuery
                await viewModel.performSearch()
            }
        }
    }

    // MARK: - Results

    private var resultsList: some View {
        ScrollView {
            LazyVStack(spacing: AppSpacing.md) {
                ForEach(viewModel.searchResults) { job in
                    NavigationLink(
                        destination: JobDetailView(job: job)
                    ) {
                        JobCardView(job: job)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(AppSpacing.md)
        }
    }

    // MARK: - Recent Searches

    private var recentSearches: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.md) {

                if !viewModel.recentSearches.isEmpty {
                    HStack {
                        Text("Recent Searches")
                            .font(AppTypography.section)
                            .foregroundStyle(AppColors.textPrimary)

                        Spacer()

                        Button("Clear") {
                            viewModel.clearHistory()
                        }
                        .font(AppTypography.bodyMedium)
                        .foregroundStyle(AppColors.primary)
                    }

                    LazyVStack(alignment: .leading, spacing: 0) {

                        ForEach(
                            viewModel.recentSearches,
                            id: \.self
                        ) { query in

                            Button {
                                viewModel.selectRecentSearch(query)

                            } label: {
                                HStack {
                                    Image(systemName: "clock.arrow.circlepath")
                                        .foregroundStyle(
                                            AppColors.textSecondary
                                        )

                                    Text(query)
                                        .font(AppTypography.body)
                                        .foregroundStyle(AppColors.textPrimary)

                                    Spacer()

                                    Image(systemName: "arrow.up.left")
                                        .foregroundStyle(
                                            AppColors.textSecondary
                                        )
                                }
                                .padding(.vertical, AppSpacing.sm)
                                .contentShape(Rectangle())
                            }

                            Divider()
                                .background(AppColors.border)
                        }
                    }

                } else {

                    VStack(spacing: AppSpacing.sm) {

                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 40))
                            .foregroundStyle(AppColors.textSecondary)

                        Text("Search for remote opportunities")
                            .font(AppTypography.body)
                            .foregroundStyle(AppColors.textSecondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 60)
                }
            }
            .padding(AppSpacing.md)
        }
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: AppSpacing.sm) {

            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 60))
                .foregroundStyle(AppColors.textSecondary)

            Text("No Results Found")
                .font(AppTypography.section)
                .foregroundStyle(AppColors.textPrimary)

            Text("Try adjusting your search terms")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    JobSearchView()
}
