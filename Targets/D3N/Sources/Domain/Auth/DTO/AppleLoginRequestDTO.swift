//
//  AppleLoginRequestDTO.swift
//  D3N
//
//  Created by 송영모 on 11/3/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

struct AppleLoginRequestDTO: Codable {
    let code, idToken: String

    enum CodingKeys: String, CodingKey {
        case code
        case idToken = "id_token"
    }
}
