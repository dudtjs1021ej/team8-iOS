//
//  FeedRequest.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/26.
//

import Foundation

//struct FeedResponse: Codable {
//  let cats: [Feed]
//}
//
//// MARK: - Feed
//struct Feed: Codable {
//  let id, cat_id: Int
//  let title, content: String
//  let image_url: String
//}

struct FeedResponse: Codable {
    let cats: [Cat]
}

// MARK: - Cat
struct Cat: Codable {
    let catID, id: Int
    let title, content: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case catID = "cat_id"
        case id, title, content
        case imageURL = "image_url"
    }
}




