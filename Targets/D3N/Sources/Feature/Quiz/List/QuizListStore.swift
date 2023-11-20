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
        var quizEntityList: [QuizEntity]
        
        var currentTab: Int = 0
        var currentIndex: Int = 0
        var isActive: Bool = false
        
        var quizListItems: IdentifiedArrayOf<QuizListItemCellStore.State> = []
        
        public init(quizEntityList: [QuizEntity]) {
            self.quizEntityList = quizEntityList
            
            self.quizListItems = .init(
                uniqueElements: quizEntityList.map {
                    return .init(
                        id: $0.id,
                        question: $0.question,
                        choices: $0.choiceList,
                        answer: $0.answer,
                        reason: $0.reason,
                        userAnswer: $0.userAnswer
                    )
                }
            )
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case setTab(Int)
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
                
            case let .setTab(tab):
                state.currentTab = tab
                return .none
                
            case let .quizListItems(id: id, action: .delegate(action)):
                switch action {
                case let .submit(userAnswer):
                    if let index = state.quizEntityList.firstIndex(where: { $0.id == id }) {
                        state.quizEntityList[index].userAnswer = userAnswer
                    }
                    return .none
                }
                
//            case .solvedButtonTapped:
//                if state.isActive {
//                    let quizEntityList = state.quizListItems.map { return $0.quizEntity }
//                    return .send(.delegate(.solved(quizEntityList)))
//                }
//                return .none
//                
//            case let .quizListItems(id: id, action: .delegate(action)):
//                switch action {
//                case let .userAnswered(answer):
//                    state.quizListItems[id: id]?.quizEntity.userAnswer = answer
//                    state.isActive = !state.quizListItems.contains(where: { $0.quizEntity.userAnswer == nil })
//                    return .none
//                }
                
            default:
                return .none
            }
        }
        .forEach(\.quizListItems, action: /Action.quizListItems(id:action:)) {
            QuizListItemCellStore()
        }
    }
}
