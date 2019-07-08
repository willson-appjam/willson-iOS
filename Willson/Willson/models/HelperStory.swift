//
//  HelperStory.swift
//  Willson
//
//  Created by JHKim on 09/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation

struct HelperStory: Codable {
    
    struct CustomData: Codable {
        let nickname: String
        let category_name: String
        let content: String
    }
    
    let code: Int
    let data: [CustomData]?
    
    init() {
        code = 0
        data = []
    }
}
