//
//  FeedCellView.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import SwiftUI

struct FeedCellView: View {
    let item: FeedItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageURL = item.imageURL {
                image(url: imageURL)
            }
            
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
    
    private func image(url: URL) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(height: 200)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .clipped()
            case .failure:
                Color.gray
                    .frame(height: 200)
            default:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    FeedCellView(item: FeedItem(id: 1, name: "qwe", username: "qwe", postTitle: "qwe", postBody: "qwetyy", imageURL: nil))
}
