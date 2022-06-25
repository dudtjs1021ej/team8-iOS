//
//  FeedViewController.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/25.
//

import UIKit

class FeedViewController: UIViewController {
  @IBOutlet weak var feedCollectionView: UICollectionView!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      feedCollectionView.register(UINib(nibName: "FeedCell", bundle: .main), forCellWithReuseIdentifier: "FeedCell")
      feedCollectionView.delegate = self
      feedCollectionView.dataSource = self
      
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = CGSize(width: self.view.frame.width - 32, height: 118)
      
      feedCollectionView.collectionViewLayout = layout
    }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden = true
  }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as? FeedCell else { return UICollectionViewCell() }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = FeedDetailViewController()
    vc.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(vc, animated: true)

  }
}
