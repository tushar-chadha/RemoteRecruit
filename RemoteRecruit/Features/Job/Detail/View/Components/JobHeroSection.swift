//
//  JobHeroSection.swift.swift
//  RemoteRecruit
//
//  Created by tushar on 07/06/26.
//

import SwiftUI

struct JobHeroSection: View {
    let job: Job
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            companyLogo
            VStack(alignment: .leading) {

                Text(job.title)
                    .font(.system(size: 28, weight: .bold))
                    .multilineTextAlignment(.leading)

                HStack(spacing: 8) {
                    Text(job.companyName)
                    Circle()
                        .frame(width: 4)
                    Text(job.locationText)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }

            HStack(spacing: 8, ) {

                if let type = job.employmentType {
                    JobTag(text: type)
                }

                JobTag(text: "Remote")

            }
        }.frame(maxWidth: .infinity)
            .padding(.top, 24)
    }
}
extension JobHeroSection {
    fileprivate var companyLogo: some View {

        AsyncImage(url: URL(string: job.companyLogo ?? "")) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {

            Image(systemName: "building.2.fill")
                .font(.largeTitle)
                .foregroundStyle(.secondary)

        }.frame(width: 72, height: 72)
            .background(.white)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 20
                )
            )
            .shadow(
                color: .black.opacity(0.08),
                radius: 12,
                y: 6
            )

    }
}
#Preview {
    JobHeroSection(job: .mock)
}
