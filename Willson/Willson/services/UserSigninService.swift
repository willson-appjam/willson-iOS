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
    let header = [
        "Content-Type" : "application/json"
    ]
    
    func login(email: String, password: String, completionHandler: @escaping (SignIn, Int) -> Void) {
        let body: Parameters = [
            "email" : email,
            "password": password
        ]
        
        let URL = "\(SERVER_URL)/user/signin"

        Alamofire.request(URL,
            method: .post,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: header).responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    do {
                        let signindata = try JSONDecoder().decode(SignIn.self, from: data)
                        guard let statusCode = dataResponse.response?.statusCode else { return }
                        completionHandler(signindata, statusCode)
                        print("~~~~~~~~~~~~~~~~~~~yeahahdhhahaha~~~~~~~~~~~~~~~~~~~")
                    } catch {
                        print("Got and error: \(error)")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }

//    static let shared = UserSigninService()
//    let header: HTTPHeaders = [
//        "Content-Type" : "application/json"
//    ]
//
//    func login(_ email: String, _ password: String, completion: @escaping (NetworkResult<Any>) -> Void)  {
//        //통신의 상태는 5가지가 NetworkResult.swift 파일에 정의되어 있음
//        let body: Parameters = [
//            "email": email,
//            "password": password
//        ]
//
//        let URL = "\(SERVER_URL)/user/signin"
//
//        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
//            .responseData { response in
//
//                switch response.result {
//
//                case .success(let data):
//                    if let value = response.result.value {
//                        if let status = response.response?.statusCode {
//
//                            switch status {
//                            case 200:
//                                do {
//                                    let decoder = JSONDecoder()
//                                    let result = try decoder.decode(ResponseArray<signinData>.self, from: value)
//
//                                    if (result.code == 200) {
//                                        completion(.success(result.data!))
//                                    }
//                                } catch {
//                                    completion(.pathErr)
//                                }
//                            case 400:
//                                completion(.pathErr)
//                            case 500:
//                                completion(.serverErr)
//
//                            default:
//                                break
//                            }
//                        }
//                    }
//                    break
//
//                case .failure(let err):
//                    print(err.localizedDescription)
//                    //completion(.networkFail)
//                    break
//                }
//        }
//    }
}
