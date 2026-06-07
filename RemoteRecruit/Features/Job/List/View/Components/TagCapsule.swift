import SwiftUI

struct TagCapsule: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(AppTypography.captionMedium)
            .foregroundStyle(AppColors.chipText)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(AppColors.chipBackground)
            .clipShape(Capsule())
    }
}

#Preview {
    TagCapsule(text: "Remote")
}
