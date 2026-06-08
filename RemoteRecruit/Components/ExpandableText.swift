import SwiftUI

struct ExpandableText: View {
    let text: String
    let limit: Int
    @State private var expanded = false

    init(
        text: String,
        limit: Int = 150
    ) {
        self.text = text
        self.limit = limit
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(displayText)
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(6)

            if text.count > limit {
                Button {
                    withAnimation(.easeInOut) {
                        expanded.toggle()
                    }
                } label: {
                    Text(expanded ? "Show Less" : "Show More")
                        .font(AppTypography.bodyMedium)
                        .foregroundStyle(AppColors.primary)
                }
            }
        }
    }

    private var displayText: String {
        if expanded {
            return text
        }

        if text.count <= limit {
            return text
        }

        return String(text.prefix(limit)) + "..."
    }
}
