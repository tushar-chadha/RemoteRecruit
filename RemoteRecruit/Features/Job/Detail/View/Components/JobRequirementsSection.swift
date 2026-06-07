//
//  JobRequirementsSection.swift
//  RemoteRecruit
//
//  Created by tushar on 07/06/26.
//

import SwiftUI

struct JobRequirementsSection: View {
    let job: Job
    
    private var requirements: [String] {
        JobParser.requirements(from: job.description)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionTitle(title: "Requirements")
                .font(.title2.bold())
            
            ForEach(requirements, id: \.self) { item in
                HStack(alignment: .top) {
                    Circle()
                        .fill(AppColors.primary)
                        .frame(width: 8, height: 8)
                        .padding(.top, 6)
                    
                    Text(item)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                }
            }
        }
    }
}

#Preview {
    JobRequirementsSection(job: .mock)
}
