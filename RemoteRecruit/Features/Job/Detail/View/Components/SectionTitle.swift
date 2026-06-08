
import SwiftUI

struct SectionTitle: View {

    let title: String

    var body: some View {

        HStack(spacing: 10) {

            Rectangle()
                .fill(.blue)
                .frame(width: 16, height: 2)

            Text(title)
                .font(.title3.bold())
        }
    }
}

#Preview {
    SectionTitle(title: "Requirements")
}
