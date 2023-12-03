//
//  FetchQuizListResponseDTO.swift
//  D3N
//
//  Created by 송영모 on 11/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

typealias FetchQuizListResponseDTO = [FetchQuizListResponseElement]

struct FetchQuizListResponseElement: Codable {
    let id: Int
    let question: String
    let choiceList: [String]
    let answer: Int
    let reason: String
    let secondTime: Int
    let selectedAnswer: Int?
    let level: Int
}

extension FetchQuizListResponseElement {
    func toEntity() -> QuizEntity {
        return .init(
            id: self.id,
            question: self.question,
            choiceList: self.choiceList,
            answer: self.answer,
            reason: self.reason,
            secondTime: self.secondTime,
            selectedAnswer: self.selectedAnswer,
            level: self.level
        )
    }
}
