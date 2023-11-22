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
        public var id: Int
        var isSolved: Bool
        
        var question: String
        var choices: [String]
        var answer: Int
        var reason: String
        var secondTime: Int
        var selectedAnswer: Int?
        
        init(
            id: Int = .init(),
            isSolved: Bool,
            question: String,
            choices: [String],
            answer: Int,
            reason: String,
            secondTime: Int,
            selectedAnswer: Int? = nil
        ) {
            self.id = id
            self.isSolved = isSolved
            self.question = question
            self.choices = choices
            self.answer = answer
            self.reason = reason
            self.secondTime = secondTime
            self.selectedAnswer = selectedAnswer
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case answered(Int)
        case submitButtonTappped
        
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
                
            case let .answered(userAnswer):
                if state.selectedAnswer == userAnswer {
                    state.selectedAnswer = nil
                } else {
                    state.selectedAnswer = userAnswer
                }
                return .none
                
            case .submitButtonTappped:
                if let userAnswer = state.selectedAnswer {
                    return .send(.delegate(.submit(userAnswer)))
                }
                return .none
                
            default:
                return .none
            }
        }
    }
}
