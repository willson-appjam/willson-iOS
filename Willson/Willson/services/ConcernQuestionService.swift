//
//  ConcernQuestionService.swift
//  Willson
//
//  Created by JHKim on 12/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Alamofire

struct ConcernQuestionService {
    static let shared = ConcernQuestionService()
    
    func postConcernQuestionService(concernQuestionPost: ConcernQuestionPost, completionHandler: @escaping (ConcernQuestion, Int) -> Void) {
        let url = "\(SERVER_URL)/concern/question"
        let params = [
            "question" : concernQuestionPost.question,
            "feeling" : concernQuestionPost.feeling,
            "personality" : concernQuestionPost.personality,
            "experience" : concernQuestionPost.experience
            ] as [String : Any]
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let header = [
            "user_session" : token,
            "Content-Type" : "application/json"
        ]
        Alamofire.request(url,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: header).responseData { dataResponse in
                            switch dataResponse.result {
                            case .success(let data):
                            do {
                            let concernQuestion = try JSONDecoder().decode(ConcernQuestion.self, from: data)
                            guard let statusCode = dataResponse.response?.statusCode else { return }
                            completionHandler(concernQuestion, statusCode)
                            print("**************concern question success*************")
                            } catch {
                            print("Got and error: \(error)")
                            }
                            case .failure(let error):
                            print(error.localizedDescription)
                            }
        }
    }
}
