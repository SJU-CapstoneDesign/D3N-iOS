//
//  SolvedQuizListStore.swift
//  D3N
//
//  Created by Younghoon Ahn on 11/23/23.
//  Copyright © 2023 sju. All rights reserved.
//

import ComposableArchitecture

public struct SolvedNewsNavigationStackStore: Reducer {
    public struct State: Equatable {
        var main: SolvedNewsStore.State = .init()
        
        var path: StackState<Path.State> = .init()
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        
        case main(SolvedNewsStore.Action)
        case path(StackAction<Path.State, Path.Action>)
        
        case popToRoot
        case delegate(Delegate)
        
        public enum Delegate {
            case complete
        }
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case quizMain(QuizMainStore.State)
            case quizResult(QuizResultStore.State)
            case solvedNews(SolvedNewsStore.State)
        }
        
        public enum Action: Equatable {
            case quizMain(QuizMainStore.Action)
            case quizResult(QuizResultStore.Action)
            case solvedNews(SolvedNewsStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.quizMain, action: /Action.quizMain) {
                QuizMainStore()
            }
            Scope(state: /State.quizResult, action: /Action.quizResult) {
                QuizResultStore()
            }
            Scope(state: /State.solvedNews, action: /Action.solvedNews) {
                SolvedNewsStore()
            }
        }
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .main(.delegate(action)):
                switch action {
                case let .select(newsEntity):
                    state.path.append(.quizMain(.init(newsEntity: newsEntity)))
                    return .none
                }
                
            case let .path(.element(id: _, action: .quizMain(.delegate(action)))):
                switch action {
                case let .solved(quizEntityList):
                    state.path.append(.quizResult(.init(quizEntityList: quizEntityList)))
                    return .none
                }
                
            case let .path(.element(id: _, action: .quizResult(.delegate(action)))):
                switch action {
                case .backToRoot:
                    return .send(.popToRoot)
                }
                
            case let .path(.element(id: _, action: .solvedNews(.delegate(action)))):
                switch action {
                case let .select(newsEntity):
                    state.path.append(.quizMain(.init(newsEntity: newsEntity)))
                }
                return .none
                
            case .popToRoot:
                state.path.removeAll()
                return .none
                
            default:
                return .none
            }
        }
        Scope(state: \.main, action: /Action.main) {
            SolvedNewsStore()
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
