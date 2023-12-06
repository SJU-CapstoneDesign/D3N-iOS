//
//  SolvedQuizEntity.swift
//  D3N
//
//  Created by Younghoon Ahn on 11/28/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct SolvedQuizEntity: Equatable, Codable {
    let id: Int
    let question: String
    let choiceList: [String]
    let answer: Int
    let reason: String
    let selectedAnswer: Int
    let news: NewsEntity
    
    init(id: Int,
        question: String,
        choiceList: [String],
        answer: Int,
        reason: String,
        selectedAnswer: Int,
        news: NewsEntity
    ) {
        self.id = id
        self.question = question
        self.choiceList = choiceList
        self.answer = answer
        self.reason = reason
        self.selectedAnswer = selectedAnswer
        self.news = news
    }
}
