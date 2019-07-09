//
//  HelperStoryService.swift
//  Willson
//
//  Created by JHKim on 09/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation
import Alamofire

struct HelperStoryService {
    static let shared = HelperStoryService()
    
    /*func getHelperStory(completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = "\(SERVER_URL)/helper/story"
        print(URL)
        
        Alamofire.request(URL,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil).responseData { response in
                            switch response.result {
                            case .success:
                                if let value = response.result.value {
                                    if let status = response.response?.statusCode {
                                        switch status {
                                        case 200:
                                            do {
                                                let decoder = JSONDecoder()
                                                let result = try decoder.decode(ResponseArray<HelperStory>.self, from: value)
                                                
                                                if (result.code == 200) {
                                                    completion(.success(response.data!))
                                                }
                                                else{
                                                    //completion(.requestErr(result.message))
                                                }
                                            } catch {
//                                                completion(.pathErr)
                                                print("catch로 들어왔어여...")
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
                                
                            case .failure(let err):
                                print(err.localizedDescription)
                                completion(.networkFail)
                                break
                            }
        }
        
    }*/
}
