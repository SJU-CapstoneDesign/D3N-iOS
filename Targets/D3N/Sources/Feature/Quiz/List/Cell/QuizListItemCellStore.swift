//
//  QuizListItemCellStore.swift
//  D3N
//
//  Created by 송영모 on 10/14/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct QuizListItemCellStore: Reducer {
    public struct State: Equatable, Identifiable {
        public var id: UUID
        
        var question: String
        var choices: [String]
        var answer: Int
        var reason: String
        var userAnswer: Int?
        
        init(
            id: UUID = .init(),
            question: String,
            choices: [String],
            answer: Int,
            reason: String,
            userAnswer: Int? = nil
        ) {
            self.id = id
            self.question = question
            self.choices = choices
            self.answer = answer
            self.reason = reason
            self.userAnswer = userAnswer
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case answered(Int)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case answered(Int)
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .answered(userAnswer):
                state.userAnswer = userAnswer
                return .send(.delegate(.answered(userAnswer)))
                
            default:
                return .none
            }
        }
    }
}
