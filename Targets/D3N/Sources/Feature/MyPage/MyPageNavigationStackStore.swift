//
//  MyPageNavigationStackStore.swift
//  D3N
//
//  Created by 송영모 on 10/15/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct MyPageNavigationStackStore: Reducer {
    public struct State: Equatable {
        var main: MyPageMainStore.State = .init()
        var solvedNews: SolvedNewsNavigationStackStore.State? = .init()
        var path: StackState<Path.State> = .init()
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case popToRoot
        case path(StackAction<Path.State, Path.Action>)
        
        case solvedNews(SolvedNewsNavigationStackStore.Action)
        
        case main(MyPageMainStore.Action)
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case unlinked
            case select(NewsEntity)
        }
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case detail(TodayDetailStore.State)
            case quizMain(QuizMainStore.State)
            case quizResult(QuizResultStore.State)
            case solvedNews(SolvedNewsStore.State)
        }
        
        public enum Action: Equatable {
            case detail(TodayDetailStore.Action)
            case quizMain(QuizMainStore.Action)
            case quizResult(QuizResultStore.Action)
            case solvedNews(SolvedNewsStore.Action)
            case popToRoot
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
            case let .main(.delegate(action)):
                switch action {
                case let .select(newsEntity):
                    state.path.append(.quizMain(.init(newsEntity: newsEntity)))
                    return .none
                case .unlinked:
                    return .send(.delegate(.unlinked))
                case .solvedNewsButtonTapped:
                    state.path.append(.solvedNews(.init()))
                    return .none
                }
                
            case let .path(.element(id: _, action: .solvedNews(.delegate(action)))):
                switch action {
                case let .select(newsEntity):
                    state.path.append(.quizMain(.init(newsEntity: newsEntity)))
                }
                return .none
                
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
                
            case .popToRoot:
                state.path.removeAll()
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.solvedNews, action: /Action.solvedNews) {
            SolvedNewsNavigationStackStore()
        }
        Scope(state: \.main, action: /Action.main) {
            MyPageMainStore()
        }
    }
}
