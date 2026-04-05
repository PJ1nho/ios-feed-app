//
//  DetailsViewModel.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import SwiftUI
import Combine

@MainActor
final class DetailsViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var comments: [Comment] = []
    @Published var errorMessage: String?
    @Published var isLoading = false

    // MARK: - Public Properties

    let feedItem: FeedItem

    // MARK: - Private Properties

    private let apiClient: ApiClientProtocol

    // MARK: - Init

    init(feedItem: FeedItem, apiClient: ApiClientProtocol) {
        self.feedItem = feedItem
        self.apiClient = apiClient
    }

    // MARK: - Public Methods

    func loadComments() async {
        isLoading = true
        errorMessage = nil
        
        do {
            comments = try await apiClient.fetchComments(for: feedItem.id)
        } catch {
            errorMessage = "Failed to load comments"
        }
        
        isLoading = false
    }
}
