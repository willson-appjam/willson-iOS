//
//  ReviewStory.swift
//  Willson
//
//  Created by 박지수 on 11/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation

// MARK: - ReviewStory
struct ReviewStory: Codable {
    let code: Int
    let message: String
    let data: [ReviewStoryData]
}

// MARK: - ReviewStoryData
struct ReviewStoryData: Codable {
    let categoryName, content, nickname: String
    
    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case content, nickname
    }
}
