//
//  ApiClient.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidResponse
    case httpStatus(Int)
    case decoding(Error)
}

protocol ApiClientProtocol {
    func fetchUsers() async throws -> [User]
    func fetchPosts() async throws -> [Post]
    func fetchComments(for postId: Int) async throws -> [Comment]
}

final class ApiClient {
    static let usersUrl = "https://jsonplaceholder.typicode.com/users"
    static let postsUrl = "https://jsonplaceholder.typicode.com/posts"
    static let commentsUrl = "https://jsonplaceholder.typicode.com/comments"
}

extension ApiClient: ApiClientProtocol {
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: ApiClient.usersUrl) else {
            throw NetworkError.badURL
        }
        return try await fetch([User].self, from: url)
    }

    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: ApiClient.postsUrl) else {
            throw NetworkError.badURL
        }
        return try await fetch([Post].self, from: url)
    }

    func fetchComments(for postId: Int) async throws -> [Comment] {
        guard var components = URLComponents(string: ApiClient.commentsUrl) else {
            throw NetworkError.badURL
        }

        components.queryItems = [
            URLQueryItem(name: "postId", value: "\(postId)")
        ]

        guard let url = components.url else {
            throw NetworkError.badURL
        }

        return try await fetch([Comment].self, from: url)
    }
}

private extension ApiClient {
    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpStatus(httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw NetworkError.decoding(error)
        }
    }
}
