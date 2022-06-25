//
//  CatDetailViewController.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/25.
//

import UIKit

class CatDetailViewController: UIViewController {
  
  @IBOutlet weak var feedCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    feedCollectionView.register(UINib(nibName: "CatFeedCell", bundle: .main), forCellWithReuseIdentifier: "CatFeedCell")
    feedCollectionView.register(UINib(nibName: "CatInfoCell", bundle: .main), forCellWithReuseIdentifier: "CatInfoCell")
    feedCollectionView.register(UINib(nibName: "CatFeedPlusCell", bundle: .main), forCellWithReuseIdentifier: "CatFeedPlusCell")
    feedCollectionView.delegate = self
    feedCollectionView.dataSource = self

  }
}


extension CatDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    }
    else {
      return 10
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 {
      guard let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "CatInfoCell", for: indexPath) as? CatInfoCell else { return UICollectionViewCell() }
      return cell
    }
    else {
      if indexPath.row == 0 {
        guard let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "CatFeedPlusCell", for: indexPath) as? CatFeedPlusCell else { return UICollectionViewCell() }
        return cell
      }
      
      else {
        guard let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "CatFeedCell", for: indexPath) as? CatFeedCell else { return UICollectionViewCell() }
        return cell
        
      }
      
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    if section == 0 {
      return 0
    }
    else {
      return 18
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if section == 0 {
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    else {
      return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.section == 0 {
      return CGSize(width: collectionView.frame.width, height: 490)
    }
    
    else {
      return CGSize(width: collectionView.frame.width/2 - 20, height: collectionView.frame.width/2 - 15)
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = FeedDetailViewController()
    vc.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(vc, animated: true)

  }
  
  
}
