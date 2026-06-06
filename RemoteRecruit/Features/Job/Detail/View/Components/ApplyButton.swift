import SwiftUI

struct ApplyBottomBar: View {

    let job: Job

    var body: some View {

        HStack(spacing: 12) {

            Button {

            } label: {

                Image(systemName: "heart")
                    .font(.title3)
                    .frame(width: 52, height: 52)
                    .background(.gray.opacity(0.1))
                    .clipShape(Circle())
            }

            Link(
                destination: URL(
                    string: job.applicationLink ?? ""
                )!
            ) {

                Text("Apply Now")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 16
                        )
                    )
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(28)
        .safeAreaPadding(
            .bottom
        )
    }
}
