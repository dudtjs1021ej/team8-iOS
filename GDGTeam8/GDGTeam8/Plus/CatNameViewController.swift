//
//  CatNameViewController.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/26.
//

import UIKit

class CatNameViewController: UIViewController {

  @IBOutlet weak var catNameTextField: UITextField!
  
  @IBOutlet weak var nextButton: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
    
    
    nextButton.layer.cornerRadius = 8
    catNameTextField.addBottomBorderWithColor(color: .darkGray, height: 1, width: 5)
    }

}
