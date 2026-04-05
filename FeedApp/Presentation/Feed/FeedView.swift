//
//  FeedView.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject private var viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
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
                            viewModel.onSelectItem?(item)
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
    FeedView(viewModel: FeedViewModel(apiClient: ApiClient()))
}
