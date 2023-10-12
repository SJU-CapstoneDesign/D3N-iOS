//
//  NewsDTO.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

// MARK: - Welcome

typealias TodayNewsListResponseDTO = [TodayNewsResponseDTO]

struct TodayNewsResponseDTO: Codable {
    let field: NewsField
    let newsType: NewsType
    let title: String
    let summary: String
    let content: String
    let url: String
    let quizList: [QuizResponseDTO]
    
    func toDomain() -> NewsEntity {
        return .init(
            field: self.field,
            type: self.newsType,
            title: self.title,
            summary: self.summary,
            content: self.content,
            url: self.url,
            quizList: self.quizList.map { $0.toDomain() }
        )
    }
}

struct QuizResponseDTO: Codable {
    let question: String
    let choiceList: [String]
    let answer: Int
    let reason: String
    
    func toDomain() -> QuizEntity {
        return .init(
            question: self.question,
            choiceList: self.choiceList,
            answer: self.answer,
            reason: self.reason
        )
    }
}
