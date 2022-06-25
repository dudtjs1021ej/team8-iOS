//
//  PostCatRequest.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/26.
//

import Foundation

struct PostCatRequest: Codable {
  let image: Data
  let name: String
  let loc_x: String
  let loc_y: String
  let description: String
}

