//
//  DetailsView.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject private var viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading && viewModel.comments.isEmpty {
                ProgressView("Loading comments...")
            } else if let errorMessage = viewModel.errorMessage,
                      viewModel.comments.isEmpty {
                VStack(spacing: 12) {
                    Text(errorMessage)
                        .foregroundColor(.red)
                    
                    Button("Retry") {
                        Task {
                            await viewModel.loadComments()
                        }
                    }
                }
            } else {
                List {
                    FeedCellView(item: viewModel.feedItem)
                    
                    Section("Comments") {
                        ForEach(viewModel.comments) { comment in
                            CommentCellView(comment: comment)
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.loadComments()
        }
        .refreshable {
            await viewModel.loadComments()
        }
    }
}

#Preview {
    DetailsView(viewModel: DetailsViewModel(feedItem: FeedItem(id: 123, name: "qwe", username: "qwe", postTitle: "qwe", postBody: "qwe", imageURL: nil), apiClient: ApiClient()))
}
