//
//  NewsEntity.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct NewsEntity {
    public var title: String
    public var summary: String
    public var url: String
    public var field: String
    public let quizs: [QuizEntity]
    
    public init(
        title: String,
        summary: String,
        url: String,
        field: String,
        quizs: [QuizEntity]
    ) {
        self.title = title
        self.summary = summary
        self.url = url
        self.field = field
        self.quizs = quizs
    }
}
