//
//  FeedView.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject private var viewModel: FeedViewModel
    private let onSelectItem: (FeedItem) -> Void
    
    init(viewModel: FeedViewModel, onSelectItem: @escaping (FeedItem) -> Void) {
        self.viewModel = viewModel
        self.onSelectItem = onSelectItem
    }
    
    var body: some View {
        contentView()
        .task {
            await viewModel.loadData()
        }
        .refreshable {
            await viewModel.loadData()
        }
    }

    @ViewBuilder
    private func contentView() -> some View {
        if viewModel.isLoading && viewModel.feedItems.isEmpty {
            loadingView()
        } else if let errorMessage = viewModel.errorMessage,
                  viewModel.feedItems.isEmpty {
            errorView(message: errorMessage)
        } else {
            feedListView()
        }
    }

    private func loadingView() -> some View {
        ProgressView("Loading...")
    }

    private func errorView(message: String) -> some View {
        VStack(spacing: 12) {
            Text(message)
                .foregroundColor(.red)

            Button("Retry") {
                Task {
                    await viewModel.loadData()
                }
            }
        }
    }

    private func feedListView() -> some View {
        List(viewModel.feedItems) { item in
            FeedCellView(item: item)
                .onTapGesture {
                    onSelectItem(item)
                }
        }
    }
}

#Preview {
    FeedView(viewModel: FeedViewModel(apiClient: ApiClient()), onSelectItem: { _ in })
}
