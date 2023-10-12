//
//  QuestionListStore.swift
//  D3N
//
//  Created by 송영모 on 10/7/23.
//  Copyright © 2023 sju. All rights reserved.
//

import ComposableArchitecture

public struct QuestionListStore: Reducer {
    public struct State: Equatable {
        public var questionListItems: IdentifiedArrayOf<QuestionListItemCellStore.State> = []
        
        public init() {
            self.questionListItems = .init(uniqueElements: [
                .init(),
                .init(),
                .init(),
                .init(),
                .init(),
            ])
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case nextButtonTapped
        
        case questionListItems(id: QuestionListItemCellStore.State.ID, action: QuestionListItemCellStore.Action)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case navigateToDetail
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .nextButtonTapped:
                return .send(.delegate(.navigateToDetail))
                
            default:
                return .none
            }
        }
    }
}
