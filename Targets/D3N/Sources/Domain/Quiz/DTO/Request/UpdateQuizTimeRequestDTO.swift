//
//  UpdateQuizTimeRequestDTO.swift
//  D3N
//
//  Created by 송영모 on 11/22/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

struct UpdateQuizTimeRequestDTO: Codable {
    let quizId, secondTime: Int
}
