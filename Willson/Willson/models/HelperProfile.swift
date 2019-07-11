//
//  HelperProfile.swift
//  Willson
//
//  Created by 박지수 on 11/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation

// MARK: - HelperProfile
struct HelperProfile: Codable {
    let code: Int
    let message: String
    let data: HelperProfileData
}

// MARK: - DataClass
struct HelperProfileData: Codable {
    let helper: [Helper]
    let experience: [Experience]
    let personality: [HelperPersonality]
}

// MARK: - Experience
struct Experience: Codable {
    let experienceName: String
    
    enum CodingKeys: String, CodingKey {
        case experienceName = "experience_name"
    }
}

// MARK: - Helper
struct Helper: Codable {
    let nickname, gender, age, categoryName: String
    let title, content, stars, reviewCount: String
    
    enum CodingKeys: String, CodingKey {
        case nickname, gender, age
        case categoryName = "category_name"
        case title, content, stars
        case reviewCount = "review_count"
    }
}

// MARK: - Personality
struct HelperPersonality: Codable {
    let personalityName: String
    
    enum CodingKeys: String, CodingKey {
        case personalityName = "personality_name"
    }
}

