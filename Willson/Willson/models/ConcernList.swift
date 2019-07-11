//
//  ConcernList.swift
//  Willson
//
//  Created by 박지수 on 12/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation

// MARK: - ConcernList
struct ConcernList: Codable {
    let code: Int
    let message: String
    let data: ConcernListData
}

// MARK: - DataClass
struct ConcernListData: Codable {
    let concernInfo: [ConcernInfo]
    let size: Int
}

// MARK: - ConcernInfo
struct ConcernInfo: Codable {
    let userInfo: UserInfo
    let questionInfo: QuestionInfo
    let categoryInfo: CategoryInfo
}

// MARK: - CategoryInfo
struct CategoryInfo: Codable {
    let categoryIdx: Int
    let categoryName: String
    
    enum CodingKeys: String, CodingKey {
        case categoryIdx = "category_idx"
        case categoryName = "category_name"
    }
}

// MARK: - QuestionInfo
struct QuestionInfo: Codable {
    let title: String
    let questionIdx: Int
    let createTime: String
    let selected: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case questionIdx = "question_idx"
        case createTime = "create_time"
        case selected
    }
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let userIdx: Int
    let nickname: String
    let gender: String
    let age: String
    
    enum CodingKeys: String, CodingKey {
        case userIdx = "user_idx"
        case nickname, gender, age
    }
}
