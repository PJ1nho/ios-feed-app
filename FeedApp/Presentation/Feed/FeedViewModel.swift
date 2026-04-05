//
//  FeedViewModel.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import SwiftUI
import Combine

final class FeedViewModel: ObservableObject {
    
    @Published var feedItems: [FeedItem] = []
    @Published var errorMessage: String?
    
    let apiClient = ApiClient()
    
    func loadData() async {
        async let users = apiClient.fetchUsers()
        async let posts = apiClient.fetchPosts()
        
        do {
            let (users, posts) = try await (users, posts)
            feedItems = mapFeedItems(posts: posts, users: users)
        } catch {
            errorMessage = "Failed to load feed"
        }
    }
    
    private func mapFeedItems(posts: [Post], users: [User]) -> [FeedItem] {
        let usersById = Dictionary(uniqueKeysWithValues: users.map { ($0.id, $0) })
        
        return posts.map { post in
            let user = usersById[post.userId]
            
            return FeedItem(
                id: post.id,
                name: user?.name ?? "Unknown",
                username: user?.username ?? "Unknown",
                postTitle: post.title,
                postBody: post.body
            )
        }
    }
}
