//
//  SceneDelegate.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    // 윈도우의 크기 설정
    window = UIWindow(frame: UIScreen.main.bounds)
    
    // 뷰컨트롤러 인스턴스 설정
    let mainTC = TabBarViewController()
    
    // 뿌리 뷰컨트롤러를 위에서 설정한 네이게이션 컨트롤러로 설정
    window?.rootViewController = mainTC
    
    // 설정한 윈도우를 보이게 끔 설정
    window?.makeKeyAndVisible()
    
    // 윈도우 씬 설정
    window?.windowScene = windowScene
  }
}

