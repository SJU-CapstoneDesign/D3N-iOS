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
        
        var question: String
        var choices: [String]
        var answer: Int
        var reason: String
        var secondTime: Int
        var selectedAnswer: Int?
        
        var isTimerActive = true
        
        init(
            id: Int = .init(),
            question: String,
            choices: [String],
            answer: Int,
            reason: String,
            secondTime: Int,
            selectedAnswer: Int? = nil
        ) {
            self.id = id
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
        
        case timerTicked
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case submit(Int)
        }
    }
    
    @Dependency(\.continuousClock) var clock
    
    private enum CancelID { case timer }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { [isTimerActive = state.isTimerActive] send in
                    guard isTimerActive else { return }
                    for await _ in self.clock.timer(interval: .seconds(1)) {
                        await send(.timerTicked)
                    }
                }
                .cancellable(id: CancelID.timer, cancelInFlight: true)
                
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
                
            case .timerTicked:
                state.secondTime += 1
                return .none
                
            default:
                return .none
            }
        }
    }
}
