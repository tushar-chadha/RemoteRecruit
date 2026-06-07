import SwiftUI
import Combine
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

            if let linkString = job.applicationLink, let url = URL(string: linkString) {
                Link(destination: url) {
                    Text("Apply Now")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(AppColors.primary)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
                }
            } else {
                Button(action: {}) {
                    Text("Apply Not Available")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.gray)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
                }
                .disabled(true)
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
