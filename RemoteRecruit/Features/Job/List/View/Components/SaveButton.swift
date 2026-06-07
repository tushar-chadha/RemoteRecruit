import SwiftUI

struct SaveButton: View {
    @State private var isSaved: Bool = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isSaved.toggle()
            }
        }) {
            Image(systemName: isSaved ? "heart.fill" : "heart")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(isSaved ? AppColors.primary : AppColors.textSecondary)
                .frame(width: 44, height: 44) // Accessibility minimum touch target
                .contentShape(Circle())
        }
    }
}

#Preview {
    SaveButton()
}
