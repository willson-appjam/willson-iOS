//
//  HelperList.swift
//  Willson
//
//  Created by 박지수 on 12/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//
import Foundation

// MARK: - HelperList
struct HelperList: Codable {
    let code: Int
    let message: String
    let data: HelperListData
}

// MARK: - DataClass
struct HelperListData: Codable {
    let helperList: [HelperListElement]
    let size: Int
    
    enum CodingKeys: String, CodingKey {
        case helperList = "helper_list"
        case size
    }
}

// MARK: - HelperListElement
struct HelperListElement: Codable {
    let helper: Helper2
    let experience: [String]
}

// MARK: - Helper
struct Helper2: Codable {
    let nickname, age, gender: String
    let categoryIdx, categoryListIdx: Int
    let title, content, stars, reviewCount: String
    let helperIdx: Int
    
    enum CodingKeys: String, CodingKey {
        case nickname, age, gender
        case categoryIdx = "category_idx"
        case categoryListIdx = "categoryList_idx"
        case title, content, stars
        case reviewCount = "review_count"
        case helperIdx = "helper_idx"
    }
}
