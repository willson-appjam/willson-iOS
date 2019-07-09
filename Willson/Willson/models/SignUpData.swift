//
//  SignUpData.swift
//  Willson
//
//  Created by 박지수 on 10/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation

// MARK: - DataClass
struct SignUpData: Codable {
    let fieldCount, affectedRows, insertID, serverStatus: Int
    let warningCount: Int
    let message: String
    let protocol41: Bool
    let changedRows: Int
    
    enum CodingKeys: String, CodingKey {
        case fieldCount, affectedRows
        case insertID = "insertId"
        case serverStatus, warningCount, message, protocol41, changedRows
    }
}
