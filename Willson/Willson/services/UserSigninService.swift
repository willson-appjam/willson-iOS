//
//  UserSigninService.swift
//  Willson
//
//  Created by 박지수 on 09/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation
import Alamofire

struct UserSigninService { //APIConstant.swift파일 만들어 정적인 전역변수로 URL 관리
    
    static let shared = UserSigninService()
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func login(_ email: String, _ password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        //통신의 상태는 5가지가 NetworkResult.swift 파일에 정의되어 있음
        let body: Parameters = [
            "email": email,
            "password": password
        ]
        
        let URL = "\(SERVER_URL)/user/signin"
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseString.self, from: value)
                                    
                                    switch result.success {
                                    case true:
                                        completion(.success(result.data!))
                                    case false:
                                        completion(.requestErr(result.message))
                                    }
                                } catch {
                                    completion(.pathErr)
                                }
                            case 400:
                                completion(.pathErr)
                            case 500:
                                completion(.serverErr)
                                
                            default:
                                break
                            }
                        }
                    }
                    break
                    
                case .failure(let err):
                    print(err.localizedDescription)
                    completion(.networkFail)
                    break
                }
        }
    }
}
