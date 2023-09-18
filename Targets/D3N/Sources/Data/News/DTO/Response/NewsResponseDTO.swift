//
//  NewsResponseDTO.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

struct NewsResponseDTO: Codable {
    let title, summary: String
    let url: String
    let field: String
    let quizs: [QuizDTO]
    
    enum CodingKeys: String, CodingKey {
        case title
        case summary
        case url
        case field
        case quizs = "quizList"
    }
}

struct QuizDTO: Codable {
    let question: String
    let choiceList: [String]
    let answer: Int
    let reason: String
}
