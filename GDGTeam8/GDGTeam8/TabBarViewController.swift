//
//  TabBarViewController.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/25.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
  
  let transition = CircularTransition()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    self.view.backgroundColor = .white
    print("MainTabBarController - viewDidLoad() called")
    
    let catMainStoryboard = UIStoryboard(name: "CatMain", bundle: nil)
    let catMainVC = catMainStoryboard.instantiateViewController(withIdentifier: "CatMainViewController")
    
    let FeedStoryboard = UIStoryboard(name: "FeedViewController", bundle: nil)
    let feedVC = FeedStoryboard.instantiateViewController(withIdentifier: "FeedViewController")
   // let feedVC = CatDetailViewController()
    let firstNC = UINavigationController.init(rootViewController: catMainVC)
    let thirdNC = UINavigationController.init(rootViewController: feedVC)
    let finalVC = UINavigationController.init()
    
    self.viewControllers = [firstNC, thirdNC, finalVC]
    
    let firstTabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map.fill"), tag: 0)
    let thirdTabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "list.dash"), tag: 2)
    let finalTabBarItem = UITabBarItem(title: "My", image: UIImage(systemName: "person"), tag: 1)
    
    
    firstNC.tabBarItem = firstTabBarItem
    thirdNC.tabBarItem = thirdTabBarItem
    finalVC.tabBarItem = finalTabBarItem
  }
  
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    if let navVC = viewController as? UINavigationController, let _ = navVC.viewControllers.first as? PlusViewController {
      print("PlusViewController")
      
      let plusStoryboard = UIStoryboard(name: "PlusViewController", bundle: nil)
      let plusVC = plusStoryboard.instantiateViewController(withIdentifier: "PlusViewController")
      plusVC.modalPresentationStyle = .custom
      plusVC.transitioningDelegate = self
      present(plusVC, animated: true, completion: nil)
      
      return false
    }

    else {
      return true
    }
  }
  
}


extension TabBarViewController: UIViewControllerTransitioningDelegate {
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.transitionMode = .present
    transition.startingPoint = CGPoint(x: UIScreen.main.bounds.size.width, y: UIScreen.main.bounds.size.height - 120)
    transition.circleColor = .white
    return transition
  }
      
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    transition.transitionMode = .dismiss
    transition.startingPoint = CGPoint(x: UIScreen.main.bounds.size.width, y: UIScreen.main.bounds.size.height - 120)
    transition.circleColor = .white
    return transition
  }
}
