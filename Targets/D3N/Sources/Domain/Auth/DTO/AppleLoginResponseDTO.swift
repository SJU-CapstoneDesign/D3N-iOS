//
//  AuthResponseDTO.swift
//  D3N
//
//  Created by 송영모 on 11/3/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

struct AppleLoginResponseDTO: Codable {
    let appToken: String
    let refreshToken: String
}

extension AppleLoginResponseDTO {
    func toEntity(isShouldSaveAtLocalStorage: Bool = true) -> AuthEntity {
        if isShouldSaveAtLocalStorage {
            LocalStorageManager.save(.accessToken, value: self.appToken)
            LocalStorageManager.save(.refreshToken, value: self.refreshToken)
        }
        
        return .init(
            accessToken: self.appToken,
            refreshToken: self.refreshToken
        )
    }
}
