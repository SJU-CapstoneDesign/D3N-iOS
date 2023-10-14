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
        public var quiz: QuizEntity
        
        var choiceListItems: IdentifiedArrayOf<ChoiceListItemCellStore.State> = []
        
        public init(
            id: UUID = .init(),
            quiz: QuizEntity
        ) {
            self.id = id
            self.quiz = quiz
            self.choiceListItems = .init(
                uniqueElements: quiz.choiceList.map { choice in
                    return .init(choice: choice)
                }
            )
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case tapped
        
        case delegate(Delegate)
        case choiceListItems(id: ChoiceListItemCellStore.State.ID, action: ChoiceListItemCellStore.Action)
        
        public enum Delegate: Equatable {
            case tapped
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .tapped:
                return .send(.delegate(.tapped))
                
            default:
                return .none
            }
        }
        .forEach(\.choiceListItems, action: /Action.choiceListItems(id:action:)) {
            ChoiceListItemCellStore()
        }
    }
}
