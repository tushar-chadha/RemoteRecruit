import SwiftUI

struct CompanyLogo: View {
    let urlString: String?
    
    var body: some View {
        Group {
            if let urlString, let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        placeholder
                    @unknown default:
                        placeholder
                    }
                }
            } else {
                placeholder
            }
        }
        .frame(width: 60, height: 60)
        .background(AppColors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.medium)
                .stroke(AppColors.border, lineWidth: 0.5)
        )
    }
    
    private var placeholder: some View {
        Image(systemName: "building.2.fill")
            .font(.system(size: 24))
            .foregroundStyle(AppColors.textSecondary)
    }
}

#Preview {
    CompanyLogo(urlString: nil)
}
