//
//  User.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import Foundation

struct Comment: Decodable, Identifiable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
