//
//  ReviewStoryService.swift
//  Willson
//
//  Created by 박지수 on 11/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation
import Alamofire

struct ReviewStoryService {
    static let shared = ReviewStoryService()
    
    func getReviewStory(completionHandler: @escaping (ReviewStory, Int) -> Void) {
        let URL = "\(SERVER_URL)/review/story"
        
        Alamofire.request(URL,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil).responseData { response in
                            switch response.result {
                            case .success(let data): do {
                                let reviewStory = try JSONDecoder().decode(ReviewStory.self, from: data)
                                guard let statusCode = response.response?.statusCode else { return }
                                completionHandler(reviewStory, statusCode)
                                print("**************review story success*************")
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
