//
//  ConcernFeeling.swift
//  Willson
//
//  Created by 박지수 on 11/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation

// MARK: - ConcernFeeling
struct ConcernFeeling: Codable {
    let code: Int
    let message: String
    let data: ConcernFeelingData
}

// MARK: - DataClass
struct ConcernFeelingData: Codable {
    let feelingList: [FeelingList]
}

// MARK: - FeelingList
struct FeelingList: Codable {
    let feelingIdx: Int
    let feelingName: String
    
    enum CodingKeys: String, CodingKey {
        case feelingIdx = "feeling_idx"
        case feelingName = "feeling_name"
    }
}
