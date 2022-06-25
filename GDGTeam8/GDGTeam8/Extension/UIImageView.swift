//
//  UIImageView.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/26.
//

import UIKit
import Alamofire

extension UIImageView {
  func load(urlString: String) {
    guard let url = URL(string: urlString), let request = try? URLRequest(url: url, method: .get) else {
      return
    }
    
    AF.request(request).responseData { response in
      if let data = response.value, let image = UIImage(data: data) {
        self.image = image
      }
    }
//
//    if let data = try? Data(contentsOf: url!) {
//      if let image = UIImage(data: data) {
//        self.image = image
//      }
//    }
  }
}
