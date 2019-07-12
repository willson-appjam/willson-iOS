//
//  HelperListService.swift
//  Willson
//
//  Created by 박지수 on 12/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation
import Alamofire

struct HelperListService {
    static let shared = HelperListService()
    
    func getHelperList(questionID: Int, completionHandler: @escaping
        (HelperList, Int) -> Void) {
        let URL = "\(SERVER_URL)/helper/list/\(String(questionID))"
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let header = [
            "user_session" : token
        ]
        Alamofire.request(URL,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: header).responseData { response in
                            switch response.result {
                            case .success(let data): do {
                                let helperList = try JSONDecoder().decode(HelperList.self, from: data)
                                guard let statusCode = response.response?.statusCode else { return }
                                completionHandler(helperList, statusCode)
                                print("**************helper list success*************")
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
