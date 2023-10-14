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
        let news: NewsEntity
        
        @PresentationState var quizList: QuizListStore.State?
        
        public init(news: NewsEntity) {
            self.news = news
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case solveButtonTapped
        case quizList(PresentationAction<QuizListStore.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .solveButtonTapped:
                state.quizList = .init(quizs: state.news.quizList)
                return .none
                
            default:
                return .none
            }
        }
    }
}
