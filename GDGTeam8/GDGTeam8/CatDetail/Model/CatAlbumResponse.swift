//
//  CatAlbumResponse.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/26.
//

import Foundation

// MARK: - Welcome
struct CatAlbumResponse: Codable {
    let albums: [Album]
}

// MARK: - Album
struct Album: Codable {
    let id, catID: Int
    let imageURL: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case catID = "cat_id"
        case imageURL = "image_url"
        case createdAt, updatedAt
    }
}
