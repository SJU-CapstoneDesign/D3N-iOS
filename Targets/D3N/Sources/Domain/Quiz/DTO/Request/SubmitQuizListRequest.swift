//
//  SubmitQuizListRequest.swift
//  D3N
//
//  Created by 송영모 on 11/20/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct SubmitQuizListRequestElement: Codable {
    let quizId, selectedAnswer: Int
    
    public init(quizId: Int, selectedAnswer: Int) {
        self.quizId = quizId
        self.selectedAnswer = selectedAnswer
    }
}

public typealias SubmitQuizListRequestDTO = [SubmitQuizListRequestElement]
