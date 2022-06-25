//
//  FeedCell.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/26.
//

import UIKit

class FeedCell: UICollectionViewCell {

  @IBOutlet weak var backView: UIView!
  @IBOutlet weak var profileImageView: UIImageView!
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var contentLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    backView.layer.cornerRadius = 8
    backView.layer.borderColor = UIColor.borderGray.cgColor
    backView.layer.borderWidth = 1
    profileImageView.layer.cornerRadius = 11
    }

}
