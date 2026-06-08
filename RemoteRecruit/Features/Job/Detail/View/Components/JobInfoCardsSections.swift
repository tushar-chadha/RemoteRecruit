import SwiftUI

struct JobInfoCardsSection: View {

    let job: Job

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {

        LazyVGrid(
            columns: columns,
            spacing: 16
        ) {

            JobInfoCard(
                title: "Salary",
                value: job.salaryText,
                icon: "dollarsign.circle"
            )

            JobInfoCard(
                title: "Employment",
                value: job.employmentType ?? "N/A",
                icon: "briefcase"
            )

            JobInfoCard(
                title: "Location",
                value: job.locationText,
                icon: "location"
            )

            JobInfoCard(
                title: "Posted",
                value: job.postedDateText,
                icon: "calendar"
            )
        }
    }
}
