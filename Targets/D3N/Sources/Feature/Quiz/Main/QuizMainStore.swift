//
//  QuizMainStore.swift
//  D3N
//
//  Created by 송영모 on 10/14/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct QuizMainStore: Reducer {
    public struct State: Equatable { 
        var news: NewsEntity
        
        @PresentationState var quizList: QuizListStore.State?
        
        public init(news: NewsEntity) {
            self.news = news
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case solveButtonTapped
        case quizList(PresentationAction<QuizListStore.Action>)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case solved(NewsEntity)
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .solveButtonTapped:
                state.quizList = .init(quizs: state.news.quizList)
                return .none
                
            case let .quizList(.presented(.delegate(action))):
                switch action {
                case let .solved(quizs):
                    state.news.quizList = quizs
                    state.quizList = nil
                    return .send(.delegate(.solved(state.news)))
                }
                
            default:
                return .none
            }
        }
        .ifLet(\.$quizList, action: /Action.quizList) {
            QuizListStore()
        }
    }
}
