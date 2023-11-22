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
        var newsEntity: NewsEntity
        var quizEntityList: [QuizEntity] = []
        
        var isTimerActive = true
        
        @PresentationState var quizList: QuizListStore.State?
        
        public init(newsEntity: NewsEntity) {
            self.newsEntity = newsEntity
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case fetchQuizListRequest
        case fetchQuizListResponse(Result<[QuizEntity], D3NAPIError>)
        
        case solveButtonTapped
        case quizList(PresentationAction<QuizListStore.Action>)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case solved([QuizEntity])
        }
    }
    
    @Dependency(\.newsClient) var newsClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .concatenate([
                    .send(.fetchQuizListRequest)
                ])
                
            case .fetchQuizListRequest:
                return .run { [newsId = state.newsEntity.id] send in
                    let response = await newsClient.fetchQuizList(newsId)
                    await send(.fetchQuizListResponse(response))
                }
                
            case let .fetchQuizListResponse(.success(quizEntityList)):
                state.quizEntityList = quizEntityList
                return .none
                
            case .solveButtonTapped:
                state.quizList = .init(quizEntityList: state.quizEntityList)
                return .none
                
            case let .quizList(.presented(.delegate(action))):
                switch action {
                case let .solved(quizEntityList):
                    state.quizEntityList = quizEntityList
                    state.quizList = nil
                    //FIXME: 풀었던 뉴스 아이디 저장 로직 내부 구현
//                    LocalStorageRepository.saveAlreadySolvedNewsIds(ids: [state.newsEntity.id])
                    return .send(.delegate(.solved(quizEntityList)))
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
