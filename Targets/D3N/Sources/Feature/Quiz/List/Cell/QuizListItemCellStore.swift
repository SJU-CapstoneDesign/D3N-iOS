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
        
//        var choiceListItems: IdentifiedArrayOf<ChoiceListItemCellStore.State> = []
        
//        public init(
//            id: UUID = .init(),
//            quizEntity: QuizEntity
//        ) {
//            self.id = id
//            self.quizEntity = quizEntity
//            self.choiceListItems = .init(
//                uniqueElements: quizEntity.choiceList.map { choice in
//                    return .init(choice: choice)
//                }
//            )
//        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case answered(Int)
        
        case delegate(Delegate)
//        case choiceListItems(id: ChoiceListItemCellStore.State.ID, action: ChoiceListItemCellStore.Action)
        
        public enum Delegate: Equatable {
            case userAnswered(Int)
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .answered(userAnswer):
                state.userAnswer = userAnswer
                return .none
                
                
//            case let .choiceListItems(id: id, action: .delegate(action)):
//                switch action {
//                case .tapped:
//                    for id in state.choiceListItems.ids {
//                        state.choiceListItems[id: id]?.isSelected = false
//                    }
//                    state.choiceListItems[id: id]?.isSelected = true
//                    if let index = state.choiceListItems.index(id: id) {
//                        return .send(.delegate(.userAnswered(index)))
//                    }
//                    return .none
//                }
                
            default:
                return .none
            }
        }
//        .forEach(\.choiceListItems, action: /Action.choiceListItems(id:action:)) {
//            ChoiceListItemCellStore()
//        }
    }
}
