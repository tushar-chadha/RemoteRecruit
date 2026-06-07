import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel(authService: AuthService())
    
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            
            VStack(spacing: AppSpacing.lg) {
                Spacer()
                
                // MARK: - Logo & Headers
                VStack(spacing: AppSpacing.sm) {
                    Image(systemName: "globe.desk.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(AppColors.primary)
                        .padding(.bottom, AppSpacing.sm)
                    
                    Text("Find Your Dream Remote Job")
                        .font(AppTypography.title)
                        .foregroundStyle(AppColors.textPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text("Discover thousands of remote opportunities worldwide.")
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppSpacing.lg)
                }
                
                Spacer()
                
                // MARK: - Actions
                VStack(spacing: AppSpacing.md) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        // Google Sign In Button
                        Button(action: {
                            Task {
                                await viewModel.signInWithGoogle()
                            }
                        }) {
                            HStack(spacing: AppSpacing.sm) {
                                Image(systemName: "g.circle.fill")
                                    .font(.system(size: 20))
                                Text("Continue with Google")
                                    .font(AppTypography.bodyMedium)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(AppColors.cardBackground)
                            .foregroundStyle(AppColors.textPrimary)
                            .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
                            .overlay(
                                RoundedRectangle(cornerRadius: AppRadius.medium)
                                    .stroke(AppColors.border, lineWidth: 1)
                            )
                        }
                        
                        // Divider
                        HStack {
                            VStack { Divider().background(AppColors.border) }
                            Text("OR")
                                .font(AppTypography.caption)
                                .foregroundStyle(AppColors.textSecondary)
                                .padding(.horizontal, AppSpacing.xs)
                            VStack { Divider().background(AppColors.border) }
                        }
                        .padding(.vertical, AppSpacing.xs)
                        
                        // Guest Button
                        Button(action: {
                            viewModel.continueAsGuest()
                        }) {
                            Text("Continue as Guest")
                                .font(AppTypography.bodyMedium)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(AppColors.primary)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
                        }
                    }
                    
                    // Error Message
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColors.error)
                            .multilineTextAlignment(.center)
                            .padding(.top, AppSpacing.xs)
                    }
                }
                .padding(.horizontal, AppSpacing.md)
                .padding(.bottom, AppSpacing.lg)
            }
        }
    }
}

#Preview {
    AuthView()
}
