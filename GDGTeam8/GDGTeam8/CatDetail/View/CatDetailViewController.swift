//
//  CatDetailViewController.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/25.
//

import UIKit
import Alamofire

class CatDetailViewController: UIViewController {
  
  @IBOutlet weak var feedCollectionView: UICollectionView!
  
  var id: Int?
  private var catModel: CatModel?
  private var feedsModel: CatFeedsModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    feedCollectionView.register(UINib(nibName: "CatFeedCell", bundle: .main), forCellWithReuseIdentifier: "CatFeedCell")
    feedCollectionView.register(UINib(nibName: "CatInfoCell", bundle: .main), forCellWithReuseIdentifier: "CatInfoCell")
    feedCollectionView.register(UINib(nibName: "CatFeedPlusCell", bundle: .main), forCellWithReuseIdentifier: "CatFeedPlusCell")
    feedCollectionView.delegate = self
    feedCollectionView.dataSource = self
    
    setModel()
  }
  
  func setModel() {
    guard let id = id else { return }
    
    if
      let url = URL(string: "http://13.125.252.148:3000/cats/"),
      var request = try? URLRequest(url: url, method: .get) {
      
      request.url?.appendPathComponent("\(id)")
      
      AF.request(request).responseDecodable(of: WrapperCatModel.self) { response in
        self.catModel = response.value?.cat
        self.feedCollectionView.reloadData()
      }
    }
    
    if
      let url = URL(string: "http://13.125.252.148:3000/feeds/cat/"),
      var request = try? URLRequest(url: url, method: .get) {
      
      request.url?.appendPathComponent("\(id)")
      
      AF.request(request).responseDecodable(of: CatFeedsModel.self) { response in
        self.feedsModel = response.value
        self.feedCollectionView.reloadData()
      }
    }
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
      return feedsModel?.feeds.count ?? 0
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 {
      guard let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "CatInfoCell", for: indexPath) as? CatInfoCell else { return UICollectionViewCell() }
      
      cell.titleLabel.text = catModel?.name
      cell.contentLabel.text = catModel?.description
      if let urlString = catModel?.image_url {
        cell.imageView.load(urlString: urlString)
      }
      
      return cell
    }
    else {
      if indexPath.row == 0 {
        guard let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "CatFeedPlusCell", for: indexPath) as? CatFeedPlusCell else { return UICollectionViewCell() }
        return cell
      }
      
      else {
        guard let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "CatFeedCell", for: indexPath) as? CatFeedCell else { return UICollectionViewCell() }
        
        let model = feedsModel?.feeds[indexPath.item]
        
        cell.titleLabel.text = model?.title
        cell.descriptionLabel.text = ""
        
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
    if let _ = collectionView.cellForItem(at: indexPath) as? CatFeedPlusCell {
      
      let alert = UIAlertController(title: "피드 생성", message: nil, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
        guard
          let titleText = alert.textFields?.first?.text,
          let contentsText = alert.textFields?.last?.text,
          let catId = self.catModel?.id
        else {
          return
        }
        
        let param = CatFeedModel(feed: InnerCatFeedModel(id: 0, cat_id: catId, title: titleText, content: contentsText, createdAt: "", updatedAt: ""))
        
        guard let url = URL(string: "http://13.125.252.148:3000/feeds"), var request = try? URLRequest(url: url, method: .post) else {
          return
        }
        
        request.httpBody = try? JSONEncoder().encode(param)
        
        AF.request(request).responseData { response in
          switch response.result {
          case .success(_):
            self.feedsModel?.feeds.append(InnerCatFeedsModel(id: param.feed.id, cat_id: param.feed.cat_id, title: param.feed.title))
            self.feedCollectionView.reloadData()
          case .failure(_):
            return
          }
        }
      }
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
        alert.dismiss(animated: true)
      }
      
      alert.addAction(okAction)
      alert.addAction(cancelAction)
      
      alert.addTextField { textField in
        textField.placeholder = "제목"
      }
      
      alert.addTextField { textField in
        textField.placeholder = "내용"
      }
      self.present(alert, animated: true)
      
    } else {
      let vc = FeedDetailViewController()
      vc.hidesBottomBarWhenPushed = true
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
  
  
}
