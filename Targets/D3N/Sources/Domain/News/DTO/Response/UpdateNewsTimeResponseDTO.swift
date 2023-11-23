//
//  UpdateNewsTimeResponseDTO.swift
//  D3N
//
//  Created by 송영모 on 11/22/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct UpdateNewsTimeResponseDTO: Codable {
    let userId: String
    let newsId, secondTime: Int
}
