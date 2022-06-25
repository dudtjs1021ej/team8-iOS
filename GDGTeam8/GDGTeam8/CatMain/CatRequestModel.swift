//
//  CatRequestModel.swift
//  GDGTeam8
//
//  Created by 백상휘 on 2022/06/25.
//

import Foundation
import Alamofire

class CatRequestModel {
    func getAllCats(_ completionHandler: @escaping (Any) -> Void) {
        guard let url = URL(string: "http://13.125.252.148:3000/cats"), var request = try? URLRequest(url: url, method: .get) else {
            return
        }
        
        request.timeoutInterval = 3.0
        
        AF.request(request).responseDecodable(of: CatModelResult.self) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result.cats)
            case .failure(let error):
                completionHandler(error)
            }
        }
    }
}

