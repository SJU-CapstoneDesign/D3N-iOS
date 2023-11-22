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
        var quizs: [QuizEntity]
        
        var currentTab: Int = 0
        var isActive: Bool = false
        
        var quizListItems: IdentifiedArrayOf<QuizListItemCellStore.State> = []
        
        public init(quizs: [QuizEntity]) {
            self.quizs = quizs
            
            self.quizListItems = .init(
                uniqueElements: quizs.enumerated().map { index, quiz in
                    return .init(
                        id: index,
                        isSolved: quiz.selectedAnswer != nil,
                        question: quiz.question,
                        choices: quiz.choiceList,
                        answer: quiz.answer,
                        reason: quiz.reason,
                        secondTime: quiz.secondTime,
                        selectedAnswer: quiz.selectedAnswer
                    )
                }
            )
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case setTab(Int)
        case solvedButtonTapped
        
        case submitQuizListRequest([QuizEntity])
        case submitQuizListResponse(Result<[Int], D3NAPIError>)
        
        case quizListItems(id: QuizListItemCellStore.State.ID, action: QuizListItemCellStore.Action)
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case solved([QuizEntity])
        }
    }
    
    @Dependency(\.quizClient) var quizClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .setTab(tab):
                state.currentTab = tab
                state.quizListItems[id: tab]?.isTimerActive = true
                return .none
                
            case let .submitQuizListRequest(quizs):
                return .run { send in
                    await send(.submitQuizListResponse(quizClient.submit(quizs)))
                }
                
            case let .quizListItems(id: id, action: .delegate(action)):
                switch action {
                case let .submit(userAnswer):
                    if let index = state.quizs.firstIndex(where: { $0.id == id }) {
                        state.quizs[index].selectedAnswer = userAnswer
                        return .send(.submitQuizListRequest(state.quizs))
                    }
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
