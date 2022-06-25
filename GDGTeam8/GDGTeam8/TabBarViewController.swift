//
//  TabBarViewController.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/25.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    print("MainTabBarController - viewDidLoad() called")
    
    // let firstNC = UINavigationController.init(rootViewController: MapViewController())
    let plusStoryboard = UIStoryboard(name: "PlusViewController", bundle: nil)
    let plusVC = plusStoryboard.instantiateViewController(withIdentifier: "PlusViewController")
    
    
    let FeedStoryboard = UIStoryboard(name: "FeedViewController", bundle: nil)
    let feedVC = FeedStoryboard.instantiateViewController(withIdentifier: "FeedViewController")
    
    let secondNC = UINavigationController.init(rootViewController: plusVC)
    let thirdNC = UINavigationController.init(rootViewController: feedVC)
    
    
    self.viewControllers = [secondNC, thirdNC]
    
    // let firstTabBarItem = UITabBarItem(title: "첫번째", image: UIImage(systemName: "airplayaudio"), tag: 0)
    let secondTabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "plus.circle.fill"), tag: 1)
    let thirdTabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: ""), tag: 2)
    
    
    // firstNC.tabBarItem = firstTabBarItem
    secondNC.tabBarItem = secondTabBarItem
    thirdNC.tabBarItem = thirdTabBarItem
    
  }
  
}
