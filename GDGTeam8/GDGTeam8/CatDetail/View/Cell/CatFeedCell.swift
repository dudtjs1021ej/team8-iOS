//
//  CatFeedCell.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/25.
//

import UIKit

class CatFeedCell: UICollectionViewCell {

  @IBOutlet weak var backView: UIView!
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  override func awakeFromNib() {
      super.awakeFromNib()
      backView.layer.cornerRadius = 8
      self.layer.shadowColor = UIColor.lightGray.cgColor // 색깔
      self.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
      self.layer.shadowOffset = CGSize(width: 0, height: 4) // 위치조정
      self.layer.shadowRadius = 5 // 반경
      self.layer.shadowOpacity = 0.3 // alpha값
    }

}
