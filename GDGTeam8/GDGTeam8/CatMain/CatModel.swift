//
//  CatModel.swift
//  GDGTeam8
//
//  Created by 백상휘 on 2022/06/25.
//

import Foundation

struct CatModel: Codable {
    let id: Int
    let name: String
    let longitude: String
    let latitude: String
    let image_url: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case longitude = "loc_x"
        case latitude = "loc_y"
        case image_url
        case description
    }
}

struct WrapperCatModel: Codable {
    let cat: CatModel
}
