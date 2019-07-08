//
//  ResponseArray.swift
//  Willson
//
//  Created by JHKim on 09/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

struct ResponseArray<T: Codable>: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [T]? // 모든 타입을 받을 수 있습니다.
}
