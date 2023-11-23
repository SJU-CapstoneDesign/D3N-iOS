//
//  UpdateQuizTimeResponse.swift
//  D3N
//
//  Created by 송영모 on 11/22/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

struct UpdateQuizTimeResponseDTO: Codable {
    let userId: String
    let quizId, secondTime: Int
}
