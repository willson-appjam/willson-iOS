//
//  HelperMyprofile.swift
//  Willson
//
//  Created by 박지수 on 13/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation

// MARK: - HelperMyprofile
struct HelperMyprofile: Codable {
    let code: Int
    let message: String
    let data: HelperMyprofileData
}

// MARK: - DataClass
struct HelperMyprofileData: Codable {
    let helper: [Helper3]
    let experience: [Experience2]
}

// MARK: - Experience
struct Experience2: Codable {
    let experienceName: String
    
    enum CodingKeys: String, CodingKey {
        case experienceName = "experience_name"
    }
}

// MARK: - Helper
struct Helper3: Codable {
    let categoryName, categoryListName, title, content: String
    
    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case categoryListName = "categoryList_name"
        case title, content
    }
}
