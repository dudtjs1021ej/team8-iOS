//
//  UIColor.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/26.
//

import UIKit

extension UIColor {
   
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
  class var borderGray: UIColor { UIColor(hex: 0xe2e2e2) }
}
