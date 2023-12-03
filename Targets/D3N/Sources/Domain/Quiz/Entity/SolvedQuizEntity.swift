//
//  SolvedQuizEntity.swift
//  D3N
//
//  Created by Younghoon Ahn on 11/28/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct SolvedQuizEntity: Equatable {
    let id: Int
        let question: String
        let choiceList: [String]
        let answer: Int
        let reason: String
        let selectedAnswer: Int
        let news: NewsEntity
}
