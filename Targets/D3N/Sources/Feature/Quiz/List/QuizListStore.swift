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
        var isTimerActive = false
        
        var quizListItems: IdentifiedArrayOf<QuizListItemCellStore.State> = []
        
        public init(quizs: [QuizEntity]) {
            self.quizs = quizs
            
            self.quizListItems = .init(
                uniqueElements: quizs.enumerated().map { index, quiz in
                    return .init(
                        id: index,
                        isSolved: quiz.isSolved,
                        question: quiz.question,
                        choices: quiz.choiceList,
                        answer: quiz.answer,
                        reason: quiz.reason,
                        secondTime: quiz.secondTime,
                        selectedAnswer: quiz.selectedAnswer,
                        level: quiz.level
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
        case updateQuizTimeRequest(quizId: Int, secondTime: Int)
        case updateQuizTimeResponse(Result<Bool, D3NAPIError>)
        
        case timerTicked
        
        case quizListItems(id: QuizListItemCellStore.State.ID, action: QuizListItemCellStore.Action)
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case solved([QuizEntity])
        }
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.quizClient) var quizClient
    
    private enum CancelID { case timer }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isTimerActive = true
                return .run { [isTimerActive = state.isTimerActive] send in
                    guard isTimerActive else { return }
                    for await _ in self.clock.timer(interval: .seconds(1)) {
                        await send(.timerTicked)
                    }
                }
                .cancellable(id: CancelID.timer, cancelInFlight: true)
                
            case let .setTab(tab):
                state.currentTab = tab
                return .none
                
            case .timerTicked:
                let quizIndex = state.currentTab
                let quiz = state.quizs[quizIndex]
                let updatedSecondTime = quiz.secondTime + 1
                
                state.quizs[quizIndex].secondTime = updatedSecondTime
                if updatedSecondTime % 5 == 0 && !quiz.isSolved {
                    return .send(
                        .updateQuizTimeRequest(
                            quizId: quiz.id,
                            secondTime: updatedSecondTime
                        )
                    )
                } else {
                    return .none
                }
                
            case let .submitQuizListRequest(quizs):
                return .run { send in
                    await send(.submitQuizListResponse(quizClient.submit(quizs)))
                }
                
            case let .updateQuizTimeRequest(quizId: id, secondTime: time):
                return .run { send in
                    let response = await quizClient.updateTime(id, time)
                    await send(.updateQuizTimeResponse(response))
                }
                
            case let .quizListItems(id: id, action: .delegate(action)):
                switch action {
                case let .submit(userAnswer):
                    state.quizs[id].selectedAnswer = userAnswer
                    return .send(.submitQuizListRequest(state.quizs))
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
