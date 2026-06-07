import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                if viewModel.isGuest {
                    guestSection
                } else {
                    accountSection
                }
                
                settingsSection
                aboutSection
                
                if !viewModel.isGuest {
                    logoutSection
                }
            }
            .navigationTitle("Profile")
            .listStyle(.insetGrouped)
            .onAppear {
                viewModel.updateProfileState()
            }
        }
    }
    
    private var accountSection: some View {
        Section {
            HStack(spacing: AppSpacing.sm) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(AppColors.primary)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.userName ?? "User")
                        .font(AppTypography.section)
                        .foregroundStyle(AppColors.textPrimary)
                    
                    Text(viewModel.userEmail ?? "")
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                }
            }
            .padding(.vertical, AppSpacing.xs)
        } header: {
            Text("Account")
        }
    }
    
    private var guestSection: some View {
        Section {
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                Text("You are browsing as a guest.")
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textPrimary)
                
                Button(action: {
                    viewModel.loginFromGuest()
                }) {
                    Text("Continue with Google")
                        .font(AppTypography.bodyMedium)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(AppColors.primary)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, AppSpacing.xs)
        } header: {
            Text("Account")
        }
    }
    
    private var settingsSection: some View {
        Section {
            NavigationLink(destination: Text("Notifications Settings")) {
                Label("Notifications", systemImage: "bell.fill")
            }
            NavigationLink(destination: Text("Appearance Settings")) {
                Label("Appearance", systemImage: "moon.fill")
            }
        } header: {
            Text("Settings")
        }
    }
    
    private var aboutSection: some View {
        Section {
            NavigationLink(destination: Text("Privacy Policy")) {
                Label("Privacy Policy", systemImage: "hand.raised.fill")
            }
            NavigationLink(destination: Text("Terms of Service")) {
                Label("Terms of Service", systemImage: "doc.text.fill")
            }
            HStack {
                Label("Version", systemImage: "info.circle.fill")
                Spacer()
                Text("1.0.0")
                    .foregroundStyle(AppColors.textSecondary)
            }
        } header: {
            Text("About")
        }
    }
    
    private var logoutSection: some View {
        Section {
            Button(action: {
                viewModel.logout()
            }) {
                Text("Log Out")
                    .foregroundStyle(AppColors.error)
            }
        }
    }
}

#Preview {
    ProfileView()
}
