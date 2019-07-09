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
    
    func getHelperStory(completionHandler: @escaping (HelperStory, Int) -> Void) {
        let URL = "\(SERVER_URL)/helper/story"
        
        Alamofire.request(URL,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil).responseData { response in
                            switch response.result {
                            case .success(let data): do {
                                let helperStory = try JSONDecoder().decode(HelperStory.self, from: data)
                                guard let statusCode = response.response?.statusCode else { return }
                                completionHandler(helperStory, statusCode)
                                print("**************helper story success*************")
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
