//
//  ConcernListService.swift
//  Willson
//
//  Created by 박지수 on 12/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation
import Alamofire

struct ConcernListService {
    static let shared = ConcernListService()
    
    func getConcernList(completionHandler: @escaping (ConcernList, Int) -> Void) {
        let URL = "\(SERVER_URL)/concern/list"
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let header = [
            "willson-token" : token
        ]
        Alamofire.request(URL,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: header).responseData { response in
                            switch response.result {
                            case .success(let data): do {
                                let concernList = try JSONDecoder().decode(ConcernList.self, from: data)
                                guard let statusCode = response.response?.statusCode else { return }
                                completionHandler(concernList, statusCode)
                                print("**************concern list success*************")
                            } catch {
                                print("Got and error: \(error)")
                                }
                            case .failure(let err):
                                print(err.localizedDescription)
                                
                                break
                            }
        }
        
    }

}
