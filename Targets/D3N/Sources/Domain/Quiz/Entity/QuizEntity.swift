//
//  QuizEntity.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct QuizEntity: Equatable {
    let id: Int
    let question: String
    let choiceList: [String]
    let answer: Int
    let reason: String
    var secondTime: Int
    var selectedAnswer: Int?
    var level: Int
    
    var isSolved: Bool
    
    var timeString: String {
        let (h, m, s) = (secondTime / 3600, (secondTime % 3600) / 60, (secondTime % 3600) % 60)
        let hour = h > 0 ? "\(h)시간" : ""
        let minute = m > 0 ? "\(m)분" : ""
        let second = s > 0 ? "\(s)초" : ""
        
        return String(describing: "\(hour) \(minute) \(second)")
    }
    
    init(
        id: Int,
        question: String,
        choiceList: [String],
        answer: Int,
        reason: String,
        secondTime: Int,
        selectedAnswer: Int?,
        level: Int
    ) {
        self.id = id
        self.question = question
        self.choiceList = choiceList
        self.answer = answer
        self.reason = reason
        self.secondTime = secondTime
        self.selectedAnswer = selectedAnswer
        self.level = level
        
        self.isSolved = selectedAnswer != nil
    }
}
