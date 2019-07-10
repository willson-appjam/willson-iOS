//
//  ConcernPersonality.swift
//  Willson
//
//  Created by 박지수 on 11/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation

// MARK: - ConcernPersonality
struct ConcernPersonality: Codable {
    let code: Int
    let message: String
    let data: ConcernPersonalityData
}

// MARK: - DataClass
struct ConcernPersonalityData: Codable {
    let personalityList: [PersonalityList]
    let size: Int
}

// MARK: - PersonalityList
struct PersonalityList: Codable {
    let personalityIdx: Int
    let personalityName: String
    let crUser: Int
    
    enum CodingKeys: String, CodingKey {
        case personalityIdx = "personality_idx"
        case personalityName = "personality_name"
        case crUser = "cr_user"
    }
}
