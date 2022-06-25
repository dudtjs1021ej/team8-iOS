//
//  CatMainItemViewController.swift
//  GDGTeam8
//
//  Created by 백상휘 on 2022/06/25.
//

import UIKit
import Alamofire

class CatMainItemViewController: UIViewController {
    
    @IBOutlet var viewTapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var catNameLabel: UILabel!
    
    @IBOutlet weak var catDescriptionLabel: UILabel!
    
    private var model: CatModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImageView.layer.cornerRadius = mainImageView.frame.width / 2
        setModelInView()
    }
    
    private func setModelInView() {
        guard let url = URL(string: model?.image_url ?? ""), var request = try? URLRequest(url: url, method: .get) else {
            return
        }
        
        request.timeoutInterval = 3.0
        
        AF.request(request).responseData { response in
            var image: UIImage?
            
            switch response.result {
            case .success(let data):
                image = UIImage(data: data)
            case .failure(let error):
                print(error)
                image = UIImage(systemName: "xmark.circle")
            }
            
            self.mainImageView.image = image
        }
        
        catNameLabel.text = model?.name
        catDescriptionLabel.text = model?.description
    }
    
    func setData(_ cat: CatModel) {
        self.model = cat
    }
    @IBAction func viewTapGestureAction(_ sender: UITapGestureRecognizer) {
        let vc = CatDetailViewController()
        vc.id = model?.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
