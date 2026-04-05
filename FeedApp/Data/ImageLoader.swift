//
//  ImageLoader.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import UIKit

actor ImageLoader {
    static let shared = ImageLoader()
    
    private var cache: [URL: UIImage] = [:]
    
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
