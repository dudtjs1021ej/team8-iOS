//
//  UIImageView.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/26.
//

import UIKit

extension UIImageView {
  func load(urlString: String) {
    let url = URL(string: urlString)
    if let data = try? Data(contentsOf: url!) {
      if let image = UIImage(data: data) {
        self.image = image
      }
    }
  }
}
