//
//  PlusViewController.swift
//  GDGTeam8
//
//  Created by 임영선 on 2022/06/25.
//

import UIKit
import Photos

class PlusViewController: UIViewController {

  @IBOutlet weak var catImageView: UIImageView!
  @IBOutlet weak var cameraButton: UIButton!
  let picker = UIImagePickerController()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      picker.delegate = self
      
      catImageView.layer.cornerRadius = 8
      catImageView.layer.borderColor = UIColor.orange.cgColor
      catImageView.layer.borderWidth = 1
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
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      catImageView.image = image
      PostCat.shared.image = image.jpegData(compressionQuality: 1.0)
      cameraButton.isHidden = true
    }
    
    let fetchOptions = PHFetchOptions()
    fetchOptions.fetchLimit = 1
    let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
    fetchOptions.sortDescriptors = [sortDescriptor]
    
    let photo = PHAsset.fetchAssets(with: .image, options: fetchOptions)
    
    photo.enumerateObjects { asset, _, _ in
      PostCat.shared.loc_x = "\(asset.location?.coordinate.longitude ?? 0)"
      PostCat.shared.loc_y = "\(asset.location?.coordinate.latitude ?? 0)"
    }
    
    dismiss(animated: true)
    
    let vc = CatNameViewController()
    vc.modalPresentationStyle = .fullScreen
    
    present(vc, animated: true, completion: nil)
  }
}
