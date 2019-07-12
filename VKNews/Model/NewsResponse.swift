//
//  NewsResponse.swift
//  VKNews
//
//  Created by Павел Григорьев on 12/07/2019.
//  Copyright © 2019 GP. All rights reserved.
//

import Foundation

struct NewsResponseWrapped: Decodable {
    let response: NewsResponse
}
struct NewsResponse: Decodable {
    var items: [NewsItem]
}

struct NewsItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
}

struct CountableItem: Decodable {
    let count: Int
}
