
import SwiftUI

struct JobTag: View {

    let text: String
    var body: some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color.blue.opacity(0.08))
            )
    }
}

#Preview {
    JobTag(text: "hello")
}
