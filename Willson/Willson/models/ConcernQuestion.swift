//
//  ConcernQuestion.swift
//  Willson
//
//  Created by JHKim on 12/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation

struct ConcernQuestion: Codable {
    let message: String
    let code: Int
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let questionIdx: Int
    
    enum CodingKeys: String, CodingKey {
        case questionIdx = "question_idx"
    }
}
