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
        List(viewModel.feedItems) { item in
            FeedCellView(item: item)
        }
        .task {
            await viewModel.loadData()
        }
    }
}

#Preview {
    FeedView(viewModel: FeedViewModel())
}
