//
//  FeedViewModel.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import SwiftUI
import Combine

@MainActor
final class FeedViewModel: ObservableObject {
    
    @Published var feedItems: [FeedItem] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    var onSelectItem: ((FeedItem) -> Void)?
    
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func loadData() async {
        isLoading = true
        errorMessage = nil
        
        async let users = apiClient.fetchUsers()
        async let posts = apiClient.fetchPosts()
        
        do {
            let (users, posts) = try await (users, posts)
            feedItems = mapFeedItems(posts: posts, users: users)
        } catch {
            errorMessage = "Failed to load feed"
        }
        
        isLoading = false
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
                postBody: post.body,
                imageURL: URL(string: "https://picsum.photos/seed/\(post.id)/300/200")
            )
        }
    }
}
