//
//  JobsList.swift
//  RemoteRecruit
//
//  Created by tushar on 06/06/26.
//

import Foundation
import SwiftUI

struct JobListView: View {

    @StateObject
    private var viewModel: JobListViewModel
           init() {
               let service = JobService()
               _viewModel = StateObject(
                   wrappedValue: JobListViewModel(
                       jobService: service
                   )
               )
           }
    var body: some View {
            content
                .navigationTitle("Jobs")
                .task {
                    await viewModel.loadJobs()
                }
        }
    
    @ViewBuilder
       private var content: some View {
           switch viewModel.state {
           case .idle:
               Text("IDLE")
           case .loading:
               ProgressView(
                   "Loading Jobs..."
               )

           case .empty:

               EmptyStateView(
                   title: "No Jobs Found",
                   message: "Try again later"
               )

           case .error(_):
               ErrorStateView(
                   message: "OOPS"
               ) {
                   Task {
                       await viewModel.loadJobs()
                   }
               }
           case .loaded(let jobs):
               List(jobs) { job in
                   JobRowView(job: job)
               }
           case .offline:
              
               EmptyStateView(
                   title: "Offline",
                   message: "Try again later"
               )
           }
       }
   }




