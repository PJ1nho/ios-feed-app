//
//  RemoteImageView.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import SwiftUI

struct RemoteImageView: View {

    // MARK: - Public Properties

    let url: URL?

    // MARK: - Private Properties

    @State private var image: UIImage?
    @State private var isLoading = false

    // MARK: - Body

    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if isLoading {
                ProgressView()
            } else {
                Color.gray.opacity(0.2)
            }
        }
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .cornerRadius(20)
        .task(id: url) {
            await loadImage()
        }
    }

    // MARK: - Private Methods

    private func loadImage() async {
        image = nil
        isLoading = true
        defer { isLoading = false }

        guard let url else { return }

        do {
            let loadedImage = try await ImageLoader.shared.load(from: url)
            image = loadedImage
        } catch {
            image = nil
        }
    }
}

#Preview {
    RemoteImageView(url: nil)
}
