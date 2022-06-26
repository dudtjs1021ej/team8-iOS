//
//  CatImageCell.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/26.
//

import UIKit

class CatImageCell: UICollectionViewCell {

  @IBOutlet weak var countView: UIView!
  @IBOutlet weak var catImageView1: UIImageView!
  
  @IBOutlet weak var catImageView2: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
    catImageView1.layer.cornerRadius = 8
    catImageView2.layer.cornerRadius = 8
    countView.layer.cornerRadius = 8
    }

}
