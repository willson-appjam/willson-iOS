//
//  HelperProfileService.swift
//  Willson
//
//  Created by 박지수 on 11/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation
import Alamofire

struct HelperProfileService {
    static let shared = HelperProfileService()
    
    func getProfile(helperID: Int, completionHandler: @escaping (HelperProfile, Int) -> Void) {
        let URL = "\(SERVER_URL)/helper/profile/\(String(helperID))"
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
                                let helperProfile = try JSONDecoder().decode(HelperProfile.self, from: data)
                                guard let statusCode = response.response?.statusCode else { return }
                                completionHandler(helperProfile, statusCode)
                                print("**************helper profile success*************")
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
