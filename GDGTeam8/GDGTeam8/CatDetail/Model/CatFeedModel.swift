//
//  CatFeedModel.swift
//  GDGTeam8
//
//  Created by 백상휘 on 2022/06/26.
//

import Foundation

struct CatFeedModel: Codable {
  let feed: InnerCatFeedModel
}

struct InnerCatFeedModel: Codable {
  let id: Int
  let cat_id: Int
  let title: String
  let content: String
  let createdAt: String
  let updatedAt: String
}
