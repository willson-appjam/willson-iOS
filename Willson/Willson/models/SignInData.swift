//
//  DataClass.swift
//  Willson
//
//  Created by 박지수 on 09/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation
// MARK: - DataClass
struct SignInData: Codable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "Token"
    }
}
