//
//  ResponseString.swift
//  Willson
//
//  Created by 박지수 on 09/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

struct ResponseString: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: String?
}
