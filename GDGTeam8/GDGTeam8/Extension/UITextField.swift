//
//  UITextField.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/26.
//

import UIKit

extension UITextField {
  
  func addBottomBorderWithColor(color: UIColor, spacing: CGFloat = 10, height: CGFloat, width: CGFloat) {
    let border = CALayer()
    border.backgroundColor = color.cgColor
    border.frame = CGRect(
      x: 0,
      y: self.frame.size.height - height + spacing,
      width: self.frame.size.width  - width,
      height: height
    )
    self.layer.addSublayer(border)
  }
  
  func removeAllSubLayers() {
    self.layer.sublayers = nil
  }
}
