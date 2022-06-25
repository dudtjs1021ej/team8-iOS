//
//  CatInfoCell.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/25.
//

import UIKit

class CatInfoCell: UICollectionViewCell {

  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var starButton: UIButton!
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var contentLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    starButton.layer.cornerRadius = 4
  }

}
