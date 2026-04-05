//
//  CommentCellView.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import SwiftUI

struct CommentCellView: View {

    // MARK: - Public Properties

    let comment: Comment

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(comment.name)
                .font(.headline)
            
            Text(comment.email)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(comment.body)
                .font(.body)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    CommentCellView(comment: Comment(postId: 123, id: 12, name: "qwe", email: "qwe", body: "qwe"))
}
