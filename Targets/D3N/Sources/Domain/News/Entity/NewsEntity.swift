//
//  NewsEntity.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct NewsEntity: Equatable {
    let field: NewsField
    let type: NewsType
    let title: String
    let summary: String
    let content: String
    let url: String
    let quizList: [QuizEntity]
}
