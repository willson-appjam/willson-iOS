//
//  ConcernCategory.swift
//  Willson
//
//  Created by 박지수 on 10/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation

// MARK: - ConcernCategory
struct ConcernCategory: Codable {
    let code: Int
    let message: String
    let data: ConcernCategoryData
}

// MARK: - DataClass
struct ConcernCategoryData: Codable {
    let categoryList: [CategoryList]
}

// MARK: - CategoryList
struct CategoryList: Codable {
    let categoryListIdx: Int
    let categoryListName: String
    
    enum CodingKeys: String, CodingKey {
        case categoryListIdx = "categoryList_idx"
        case categoryListName = "categoryList_name"
    }
}



