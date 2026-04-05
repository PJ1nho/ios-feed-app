//
//  FeedCellView.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import SwiftUI

struct FeedCellView: View {

    // MARK: - Public Properties

    let item: FeedItem

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RemoteImageView(url: item.imageURL)
            
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
}

#Preview {
    FeedCellView(item: FeedItem(id: 1, name: "qwe", username: "qwe", postTitle: "qwe", postBody: "qwetyy", imageURL: nil))
}
