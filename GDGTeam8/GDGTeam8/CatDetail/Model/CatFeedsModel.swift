//
//  CatFeedsModel.swift
//  GDGTeam8
//
//  Created by 백상휘 on 2022/06/26.
//

import Foundation

struct CatFeedsModel: Codable {
    var feeds: [InnerCatFeedsModel]
}

struct InnerCatFeedsModel: Codable {
    let id: Int
    let cat_id: Int
    let title: String
    let content: String
}
