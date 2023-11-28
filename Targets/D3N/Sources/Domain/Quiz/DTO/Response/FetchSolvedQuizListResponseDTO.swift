//
//  SwiftUIView.swift
//  D3N
//
//  Created by Younghoon Ahn on 11/28/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

typealias FetchSolvedQuizListResponseDTO = [FetchSolvedQuizListResponseElement]

struct FetchSolvedQuizListResponseElement: Codable {
    let id: Int
        let question: String
        let choiceList: [String]
        let answer: Int
        let reason: String
        let selectedAnswer: Int
        let news: NewsEntity
    }

extension FetchSolvedQuizListResponseElement {
    func toEntity() -> SolvedQuizEntity {
        return .init(
            id: self.id,
            question: self.question,
            choiceList: self.choiceList,
            answer: self.answer,
            reason: self.reason,
            selectedAnswer: self.selectedAnswer,
            news: self.news
        )
    }
}
