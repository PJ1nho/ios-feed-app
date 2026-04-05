//
//  ApiClient.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import Foundation

final class ApiClient {
    static let usersUrl = "https://jsonplaceholder.typicode.com/users"
    static let postsUrl = "https://jsonplaceholder.typicode.com/posts"
    static let commentsUrl = "https://jsonplaceholder.typicode.com/comments"
    
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: ApiClient.usersUrl) else { return [] }
        let (users, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([User].self, from: users)
    }
    
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: ApiClient.postsUrl) else { return [] }
        let (posts, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Post].self, from: posts)
    }
    
    func fetchComments() async throws -> [Comment] {
        guard let url = URL(string: ApiClient.commentsUrl) else { return [] }
        let (comments, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Comment].self, from: comments)
    }
}
