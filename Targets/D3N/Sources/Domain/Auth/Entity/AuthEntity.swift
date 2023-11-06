//
//  AuthEntity.swift
//  D3N
//
//  Created by 송영모 on 11/3/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct AuthEntity: Codable, Equatable {
    let accessToken: String
    let refreshToken: String
}
