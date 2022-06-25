//
//  FeedRequest.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/26.
//

import Foundation

struct FeedResponse: Codable {
  let feeds: [Feed]
}

// MARK: - Feed
struct Feed: Codable {
  let id, cat_id: Int
  let title: String
}

