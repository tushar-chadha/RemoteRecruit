//
//  JobDetailsView.swift
//  RemoteRecruit
//
//  Created by tushar on 06/06/26.
//

import SwiftUI

struct JobDetailView: View {

    let job: Job

    var body: some View {

        ScrollView {
            HStack {
                CircleButton(icon: "chevron.left")
                Spacer()
                CircleButton(icon: "square.and.arrow.up")

                CircleButton(icon: "heart")
            }.padding(.horizontal, 16)
            VStack(alignment: .leading, spacing: 16) {
                JobHeroSection(job: job)
                JobInfoCardsSection(job: job)
                JobDescriptionSection(job: job)
                Divider()
                JobRequirementsSection(job: job)

                CompanySection(job: job)
            }
            .padding(16)
            ApplyBottomBar(job: job)
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(
            Color(
                UIColor(
                    red: 247 / 255,
                    green: 248 / 255,
                    blue: 250 / 255,
                    alpha: 1
                )
            )
            .ignoresSafeArea()
            .toolbar(.hidden)
        )
    }
}

#Preview {
    JobDetailView(job: .mock)
}
