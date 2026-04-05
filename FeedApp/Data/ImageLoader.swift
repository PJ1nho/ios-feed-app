//
//  ImageLoader.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import UIKit

actor ImageLoader {

    // MARK: - Shared

    static let shared = ImageLoader()

    // MARK: - Private Properties

    private var cache: [URL: UIImage] = [:]

    // MARK: - Public Methods

    func load(from url: URL) async throws -> UIImage {
        if let cachedImage = cache[url] {
            return cachedImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        
        cache[url] = image
        return image
    }
}
