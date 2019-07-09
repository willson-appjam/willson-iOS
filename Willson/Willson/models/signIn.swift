//
//  signinData.swift
//  Willson
//
//  Created by 박지수 on 09/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import Foundation

// MARK: - signinData
struct SignIn: Codable {
    let code: Int
    let data: SignInData
}

