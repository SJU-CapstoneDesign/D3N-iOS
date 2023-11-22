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
        var quizs: [QuizEntity] = []
        
        var secondTime: Int
        var isTimerActive = true
        
        @PresentationState var quizList: QuizListStore.State?
        
        public init(newsEntity: NewsEntity) {
            self.newsEntity = newsEntity
            self.secondTime = newsEntity.secondTime
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case solveButtonTapped
        
        case timerTicked
        
        case fetchQuizListRequest
        case fetchQuizListResponse(Result<[QuizEntity], D3NAPIError>)
        case updateNewsTimeRequest
        case updateNewsTimeResponse(Result<Bool, D3NAPIError>)
        
        case quizList(PresentationAction<QuizListStore.Action>)
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case solved([QuizEntity])
        }
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.newsClient) var newsClient
    @Dependency(\.quizClient) var quizClient
    
    private enum CancelID { case timer }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .concatenate([
                    .send(.fetchQuizListRequest),
                    .run { [isTimerActive = state.isTimerActive] send in
                        guard isTimerActive else { return }
                        for await _ in self.clock.timer(interval: .seconds(1)) {
                            await send(.timerTicked)
                        }
                    }
                    .cancellable(id: CancelID.timer, cancelInFlight: true)
                ])
                
            case .solveButtonTapped:
                state.quizList = .init(quizs: state.quizs)
                return .none
                
            case .timerTicked:
                state.secondTime += 1
                
                if state.secondTime % 10 == 0 {
                    return .send(.updateNewsTimeRequest)
                } else {
                    return .none
                }
                
            case .fetchQuizListRequest:
                return .run { [newsId = state.newsEntity.id] send in
                    let response = await quizClient.fetch(newsId)
                    await send(.fetchQuizListResponse(response))
                }
                
            case let .fetchQuizListResponse(.success(quizEntityList)):
                state.quizs = quizEntityList
                return .none
                
            case .updateNewsTimeRequest:
                return .run { [newsId = state.newsEntity.id, secondTime = state.secondTime ]send in
                    let response = await newsClient.updateTime(newsId, secondTime)
                    await send(.updateNewsTimeResponse(response))
                }
                
            case .updateNewsTimeResponse(.success):
                return .none
                
            case let .quizList(.presented(.delegate(action))):
                switch action {
                case let .solved(quizs):
                    state.quizs = quizs
                    state.quizList = nil
                    return .send(.delegate(.solved(quizs)))
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
