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
        contentView()
        .task {
            await viewModel.loadComments()
        }
        .refreshable {
            await viewModel.loadComments()
        }
    }

    @ViewBuilder
    private func contentView() -> some View {
        if viewModel.isLoading && viewModel.comments.isEmpty {
            loadingView()
        } else if let errorMessage = viewModel.errorMessage,
                  viewModel.comments.isEmpty {
            errorView(message: errorMessage)
        } else {
            detailsListView()
        }
    }

    private func loadingView() -> some View {
        ProgressView("Loading comments...")
    }

    private func errorView(message: String) -> some View {
        VStack(spacing: 12) {
            Text(message)
                .foregroundColor(.red)

            Button("Retry") {
                Task {
                    await viewModel.loadComments()
                }
            }
        }
    }

    private func detailsListView() -> some View {
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

#Preview {
    DetailsView(viewModel: DetailsViewModel(feedItem: FeedItem(id: 123, name: "qwe", username: "qwe", postTitle: "qwe", postBody: "qwe", imageURL: nil), apiClient: ApiClient()))
}
