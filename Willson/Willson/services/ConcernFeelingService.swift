//
//  ConcernFeelingService.swift
//  Willson
//
//  Created by 박지수 on 11/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation
import Alamofire

struct ConcernFeelingService {
    static let shared = ConcernFeelingService()
    
    func getFeeling(completionHandler: @escaping(ConcernFeeling, Int) -> Void) {
        let URL = "\(SERVER_URL)/concern/feeling"
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
                                let concernFeeling = try JSONDecoder().decode(ConcernFeeling.self, from: data)
                                guard let statusCode = response.response?.statusCode else { return }
                                completionHandler(concernFeeling, statusCode)
                                print("**************concern feeling success*************")
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
