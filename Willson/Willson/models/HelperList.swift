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
    let data: [HelperListData]
}

// MARK: - Datum
struct HelperListData: Codable {
    let age, gender: String
    let categoryIdx, categoryListIdx: Int
    let title, content, stars, reviewCount: String
    let helperIdx: Int
    
    enum CodingKeys: String, CodingKey {
        case age, gender
        case categoryIdx = "category_idx"
        case categoryListIdx = "categoryList_idx"
        case title, content, stars
        case reviewCount = "review_count"
        case helperIdx = "helper_idx"
    }
}
