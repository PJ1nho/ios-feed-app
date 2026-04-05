//
//  Post.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
