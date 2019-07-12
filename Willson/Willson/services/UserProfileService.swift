//
//  UserProfileService.swift
//  Willson
//
//  Created by 박지수 on 11/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation
import Alamofire

struct UserProfileService {
    static let shared = UserProfileService()
    
    func getProfile(userID: Int, completionHandler: @escaping (UserProfile, Int) -> Void) {
        let URL = "\(SERVER_URL)/user/profile/\(String(userID))"
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
                                let userProfile = try JSONDecoder().decode(UserProfile.self, from: data)
                                guard let statusCode = response.response?.statusCode else { return }
                                completionHandler(userProfile, statusCode)
                                print("**************user profile success*************")
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
