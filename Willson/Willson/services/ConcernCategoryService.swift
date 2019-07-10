//
//  ConcernCategoryService.swift
//  Willson
//
//  Created by 박지수 on 10/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation
import Alamofire

struct ConcernCategoryService {
    static let shared = ConcernCategoryService()
    
    func getCategory(categoryID: Int, completionHandler: @escaping (ConcernCategory, Int) -> Void) {
        let URL = "\(SERVER_URL)/concern/category/\(String(categoryID))"
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let header = [
            "user_session" : token,
        ]
        Alamofire.request(URL,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: header).responseData { response in
                            switch response.result {
                            case .success(let data): do {
                                let concernCategory = try JSONDecoder().decode(ConcernCategory.self, from: data)
                                guard let statusCode = response.response?.statusCode else { return }
                                completionHandler(concernCategory, statusCode)
                                print("**************concern category success*************")
                            } catch {
                                print("Got and error: \(error)")
                                }
                            case .failure(let err):
                                print(err.localizedDescription)
                                //completion(.networkFail)
                                break
                            }
        }

    }
}
