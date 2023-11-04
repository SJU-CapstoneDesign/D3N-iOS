//
//  UserEntity.swift
//  D3N
//
//  Created by 송영모 on 11/4/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

struct UserEntity: Codable {
    let nickname: String
    let gender: Gender
    let birthYear: Int
    let categoryList: [NewsField]
}
