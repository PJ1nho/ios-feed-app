//
//  FeedItem.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import Foundation

struct FeedItem: Identifiable {
    let id: Int
    let name: String
    let username: String
    let postTitle: String
    let postBody: String
    let imageURL: URL?
}
