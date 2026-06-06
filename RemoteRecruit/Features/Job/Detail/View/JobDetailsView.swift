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
                AppColors.background
            )
            .ignoresSafeArea()
            .toolbar {

                        // ✅ Share + Heart on the right
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            CircleButton(icon: "square.and.arrow.up",)
                            CircleButton(icon: "heart")
                        }
                    }
        )
    }
}

#Preview {
    JobDetailView(job: .mock)
}
