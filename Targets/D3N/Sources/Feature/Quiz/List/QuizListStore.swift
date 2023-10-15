//
//  QuizListStore.swift
//  D3N
//
//  Created by 송영모 on 10/14/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct QuizListStore: Reducer {
    public struct State: Equatable {
        let quizs: [QuizEntity]
        
        var quizListItems: IdentifiedArrayOf<QuizListItemCellStore.State> = []
        
        public init(quizs: [QuizEntity]) {
            self.quizs = quizs
            
            self.quizListItems = .init(
                uniqueElements: quizs.map { quiz in
                    return .init(quiz: quiz)
                }
            )
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case solvedButtonTapped
        
        case quizListItems(id: QuizListItemCellStore.State.ID, action: QuizListItemCellStore.Action)
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case solved([QuizEntity])
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .solvedButtonTapped:
                var newQuizs = state.quizListItems.map { return $0.quiz }
                return .send(.delegate(.solved(newQuizs)))
                
            case let .quizListItems(id: id, action: .delegate(action)):
                switch action {
                case let .userAnswered(answer):
                    state.quizListItems[id: id]?.quiz.userAnswer = answer
                    return .none
                    
                default:
                    return .none
                }
                
            default:
                return .none
            }
        }
        .forEach(\.quizListItems, action: /Action.quizListItems(id:action:)) {
            QuizListItemCellStore()
        }
    }
}
