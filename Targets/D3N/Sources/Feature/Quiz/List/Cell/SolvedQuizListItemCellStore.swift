//
//  SolvedQuizListItemCellStore.swift
//  D3N
//
//  Created by Younghoon Ahn on 12/1/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct SolvedQuizListItemCellStore: Reducer {
    public struct State: Equatable, Identifiable {
        public var id: Int
        
        var question: String
        var choices: [String]
        var answer: Int
        var reason: String
        var userAnswer: Int
        var news: NewsEntity
        
        init(
            id: Int = .init(),
            question: String,
            choices: [String],
            answer: Int,
            reason: String,
            userAnswer: Int,
            news: NewsEntity
        ) {
            self.id = id
            self.question = question
            self.choices = choices
            self.answer = answer
            self.reason = reason
            self.userAnswer = userAnswer
            self.news = news
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case submit(Int)
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            default:
                return .none
            }
        }
    }
}
