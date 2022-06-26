//
//  DescriptionViewController.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/26.
//

import UIKit
import Alamofire

class DescriptionViewController: UIViewController {

  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var completeButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()

    completeButton.layer.cornerRadius = 8
    textField.addBottomBorderWithColor(color: .darkGray, height: 1.5, width: 5)
    dismissKeyboardWhenTappedAround()
  }
  @IBAction func completeButtonTouchUpInside(_ sender: Any) {
    PostCat.shared.description = textField.text
    
    if let image = PostCat.shared.image,
       let name = PostCat.shared.name,
       let loc_x = PostCat.shared.loc_x,
       let loc_y = PostCat.shared.loc_y,
       let description = PostCat.shared.description {
      print(image)
      print(name)
      print(loc_x)
      print(loc_y)
      print(description)
      
      let PostCatRequest = PostCatRequest(image: image, name: name, loc_x: loc_x, loc_y: loc_y, description: description)
      
      postCat(PostCatRequest)
      
    }
    
    
    self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
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
  
  
  
}

extension DescriptionViewController {
  func postCat(_ parameters: PostCatRequest) {
    
    let header: HTTPHeaders = [
      "Content-Type": "multipart/form-data"
    ]
    
    AF.upload(
      multipartFormData: { multipartFormData in
        multipartFormData.append(parameters.name.data(using: .utf8)!, withName: "name")
        multipartFormData.append(parameters.loc_x.data(using: .utf8)!, withName: "loc_x")
        multipartFormData.append(parameters.loc_y.data(using: .utf8)!, withName: "loc_y")
        multipartFormData.append(parameters.description.data(using: .utf8)!, withName: "description")
        
//        if let image = parameters.image {
//          let aa = image
        let filename = String(Date().timeIntervalSince1970)
        multipartFormData.append(parameters.image, withName: "image",
                                   fileName:"\(filename).jpeg", mimeType: "image/jpeg")
//        } else {
//          multipartFormData.append("".data(using: .utf8)!, withName: "profileImg", fileName: "", mimeType: "")
//        }
      },
      to: "http://13.125.252.148:3000/cats",
      usingThreshold: UInt64.init(),
      method: .post,
      headers: header
    )
    .responseDecodable(of: Bool.self) { response in
      guard let result = response.value else { return }
        if result {
            NotificationCenter.default.post(name: Notification.Name.init(rawValue: "Complete"), object: nil)
        }
    }
  }
}
