//
//  Datum.swift
//  Willson
//
//  Created by 박지수 on 09/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation
// MARK: - Datum
struct HelperStoryData: Codable {
    let nickname, categoryName, content: String
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case categoryName = "category_name"
        case content
    }
}
