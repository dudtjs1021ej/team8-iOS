//
//  PlusViewController.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/25.
//

import UIKit

class PlusViewController: UIViewController {

  @IBOutlet weak var catImageView: UIImageView!
  @IBOutlet weak var cameraButton: UIButton!
  let picker = UIImagePickerController()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      picker.delegate = self
    }
  
  @IBAction func backButtonTouchUpInside(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  func openCamera() {
    picker.sourceType = .camera
    present(picker, animated: true)
  }
  @IBAction func cameraBttuonTouchUpInside(_ sender: Any) {
    openCamera()
  }
}


extension PlusViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {         catImageView.image = image
        let metadata = info[UIImagePickerController.InfoKey.mediaMetadata] as! String
        print(metadata)
        
    }
    dismiss(animated: true, completion: nil)
  }
  
}
