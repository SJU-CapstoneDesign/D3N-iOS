//
//  QuizResultStore.swift
//  D3N
//
//  Created by 송영모 on 10/15/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct QuizResultStore: Reducer {
    public struct State: Equatable {
        var quizEntityList: [QuizEntity]
        
        var collectCount: Int
        var quizResultItems: IdentifiedArrayOf<QuizResultItemCellStore.State> = []
        
        public init(quizEntityList: [QuizEntity]) {
            self.quizEntityList = quizEntityList
            self.collectCount = quizEntityList.filter({ $0.userAnswer == $0.answer }).count
            self.quizResultItems = .init(
                uniqueElements: quizEntityList.map { quizEntity in
                    return .init(quizEntity: quizEntity)
                }
            )
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case firstButtonTapped
        
        case quizResultItems(id: QuizResultItemCellStore.State.ID, action: QuizResultItemCellStore.Action)
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case backToRoot
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .firstButtonTapped:
                return .send(.delegate(.backToRoot))
                
            default:
                return .none
            }
        }
        .forEach(\.quizResultItems, action: /Action.quizResultItems(id:action:)) {
            QuizResultItemCellStore()
        }
    }
}
