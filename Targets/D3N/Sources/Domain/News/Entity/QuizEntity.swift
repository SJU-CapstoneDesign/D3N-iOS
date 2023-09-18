//
//  QuizEntity.swift
//  D3N
//
//  Created by 송영모 on 2023/09/18.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct QuizEntity {
    let question: String
    let choiceList: [String]
    let answer: Int
    let reason: String
}
