//
//  ConcernQuestionPost.swift
//  Willson
//
//  Created by 박지수 on 11/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation

// MARK: - ConcernQuestion
struct ConcernQuestionPost: Codable {
    let question: Question
    let feeling, personality: [Int]
    let experience: [String]
}

// MARK: - Question
struct Question: Codable {
    let content: String
    let weight, emotion, advise, experience: Int
    let agreement: String
    let categoryListIdx: Int
    let helperGender: String
    
    enum CodingKeys: String, CodingKey {
        case weight, content, emotion, advise, experience, agreement
        case categoryListIdx = "categoryList_idx"
        case helperGender = "helper_gender"
    }
}
