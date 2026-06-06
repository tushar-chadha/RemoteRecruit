//
//  CompanySection.swift
//  RemoteRecruit
//
//  Created by tushar on 07/06/26.
//

import SwiftUI

struct CompanySection: View {

    let job: Job

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 16
        ) {

            Text("About Company")
                .font(.title2.bold())

            HStack(spacing: 12) {

                AsyncImage(
                    url: URL(string: job.companyLogo ?? "")
                ) { image in

                    image
                        .resizable()
                        .scaledToFit()

                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)

                VStack(alignment: .leading) {

                    Text(job.companyName)
                        .font(.headline)
                    if job.companySlug != nil {
                        Text(job.companySlug ?? "")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()
            }

            Text(job.excerpt ?? "")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .shadow(
            color: .black.opacity(0.08),
            radius: 15
        )
    }
}
#Preview {
    CompanySection(job: .mock)
}
