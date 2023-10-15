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
        var news: NewsEntity
        
        var quizResultItems: IdentifiedArrayOf<QuizResultItemCellStore.State> = []
        
        public init(news: NewsEntity) {
            self.news = news
            self.quizResultItems = .init(
                uniqueElements: news.quizList.map { quiz in
                    return .init(quiz: quiz)
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
