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
    
    @Published var comments: [Comment] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    let feedItem: FeedItem
    private let apiClient: ApiClientProtocol
    
    init(feedItem: FeedItem, apiClient: ApiClientProtocol) {
        self.feedItem = feedItem
        self.apiClient = apiClient
    }
    
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
