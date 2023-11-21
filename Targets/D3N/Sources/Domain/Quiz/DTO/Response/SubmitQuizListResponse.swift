//
//  SubmitQuizListResponse.swift
//  D3N
//
//  Created by 송영모 on 11/20/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct SubmitQuizListResponseElement: Codable {
    let quizId: Int
}

public typealias SubmitQuizListResponseDTO = [SubmitQuizListResponseElement]
