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
    dismissKeyboardWhenTappedAround()
    
    
    nextButton.layer.cornerRadius = 8
    nextButton.addTarget(self, action: #selector(nextButtonTouchUpInside), for: .touchUpInside)
    catNameTextField.addBottomBorderWithColor(color: .darkGray, height: 1.5, width: 5)
    }
  
  func dismissKeyboardWhenTappedAround() {
      let tap: UITapGestureRecognizer =
          UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
//        tap.cancelsTouchesInView = false
      self.view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
      self.view.endEditing(false)
  }
  
  @objc func nextButtonTouchUpInside(_ sender: UIButton) {
    PostCat.shared.name = catNameTextField.text
    
    let vc = DescriptionViewController()
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true)
  }
  @IBAction func dismissButtonTouchUpInside(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
