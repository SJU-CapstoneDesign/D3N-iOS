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
        let quizEntityList: [QuizEntity]
        
        var currentTab: UUID = .init()
        var currentIndex: Int = 0
        var isActive: Bool = false
        
        var quizListItems: IdentifiedArrayOf<QuizListItemCellStore.State> = []
        
        public init(quizEntityList: [QuizEntity]) {
            self.quizEntityList = quizEntityList
            
            self.quizListItems = .init(
                uniqueElements: quizEntityList.map { quizEntity in
                    return .init(quizEntity: quizEntity)
                }
            )
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case setTab(UUID)
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
                state.currentIndex = state.quizListItems.index(id: tab) ?? 0
                return .none
                
            case .solvedButtonTapped:
                let quizEntityList = state.quizListItems.map { return $0.quizEntity }
                return .send(.delegate(.solved(quizEntityList)))
                
            case let .quizListItems(id: id, action: .delegate(action)):
                switch action {
                case let .userAnswered(answer):
                    state.quizListItems[id: id]?.quizEntity.userAnswer = answer
                    state.isActive = !state.quizListItems.contains(where: { $0.quizEntity.userAnswer == nil })
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
