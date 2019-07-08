//
//  NetworkResult.swift
//  Willson
//
//  Created by JHKim on 09/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

enum NetworkResult<T> {
    case success(T) // 제네릭 타입을 넣은 이유는 모든 자료형을 받을 수 있게 하기 위해
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}

