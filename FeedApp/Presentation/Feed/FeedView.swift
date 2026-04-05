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
            VStack(alignment: .leading, spacing: 8) {
                Text(item.name)
                    .font(.headline)
                
                Text("@\(item.username)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(item.postTitle)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(item.postBody)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            .padding(.vertical, 8)
        }
        .task {
            await viewModel.loadData()
        }
    }
}

#Preview {
    FeedView(viewModel: FeedViewModel())
}
