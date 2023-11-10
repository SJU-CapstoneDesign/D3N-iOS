//
//  UserOnboardResponseDTO.swift
//  D3N
//
//  Created by 송영모 on 11/4/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import Foundation

struct UserOnboardResponseDTO: Codable {
    let id: String
    let nickname: String
    let gender: Gender
    let birthDay: Int
    let categoryList: [NewsField]
}

extension UserOnboardResponseDTO {
    func toEntity() -> UserEntity {
        return .init(
            id: self.id,
            nickname: self.nickname,
            gender: self.gender,
            birthDay: self.birthDay,
            categoryList: self.categoryList
        )
    }
}
