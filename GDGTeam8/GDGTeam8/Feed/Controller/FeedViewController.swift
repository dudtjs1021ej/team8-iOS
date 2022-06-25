//
//  FeedViewController.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/25.
//

import UIKit
import Alamofire

class FeedViewController: UIViewController {
  @IBOutlet weak var feedCollectionView: UICollectionView!
  var feeds: [Feed] = []
  
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
    getFeed()
    
  }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return feeds.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as? FeedCell else { return UICollectionViewCell() }
    cell.titleLabel.text = feeds[indexPath.row].title
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


extension FeedViewController {
  // getFeed
  func getFeed() {
    AF.request("http://3.34.197.35:3000/feeds", method: .get)
      .validate()
      .responseDecodable(of: FeedResponse.self) { response in
        print(response)
        switch response.result {
        case .success(let result):
          print(result)
          self.feeds = result.feeds
          self.feedCollectionView.reloadData()

        case .failure(let error):
          print("getFeed failure \(error.localizedDescription)")
        }
      }
  }
}
