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
        Group {
            if viewModel.isLoading && viewModel.feedItems.isEmpty {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage,
                      viewModel.feedItems.isEmpty {
                VStack(spacing: 12) {
                    Text(errorMessage)
                        .foregroundColor(.red)
                    
                    Button("Retry") {
                        Task {
                            await viewModel.loadData()
                        }
                    }
                }
            } else {
                List(viewModel.feedItems) { item in
                    FeedCellView(item: item)
                        .onTapGesture {
                            onSelectItem(item)
                        }
                }
            }
        }
        .task {
            await viewModel.loadData()
        }
        .refreshable {
            await viewModel.loadData()
        }
    }
}

#Preview {
    FeedView(viewModel: FeedViewModel(apiClient: ApiClient()), onSelectItem: { _ in })
}
