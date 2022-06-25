//
//  CatMainItemViewController.swift
//  GDGTeam8
//
//  Created by 백상휘 on 2022/06/25.
//

import UIKit

class CatMainItemViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: CGFloat.random(in: 0.0...1.0), green: CGFloat.random(in: 0.0...1.0), blue: CGFloat.random(in: 0.0...1.0), alpha: 1)
    }
}
