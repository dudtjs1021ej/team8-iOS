//
//  PostCat.swift
//  GDGTeam8
//
//  Created by 백상휘 on 2022/06/26.
//

import Foundation

class PostCat {
  static let shared = PostCat()
  
  var image: Data?
  var name : String?
  var loc_x: String?
  var loc_y: String?
  var description: String?
}
