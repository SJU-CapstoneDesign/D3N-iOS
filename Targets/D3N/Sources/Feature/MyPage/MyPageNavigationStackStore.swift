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
        var path: StackState<Path.State> = .init()
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case popToRoot
        case path(StackAction<Path.State, Path.Action>)
        case onAppear
        case solvedNews(SolvedNewsStore.Action)
        
        case main(MyPageMainStore.Action)
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case unlinked
            case select(NewsEntity)
            case complete
        }
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case quizMain(QuizMainStore.State)
            case solvedNews(SolvedNewsStore.State)
        }
        
        public enum Action: Equatable {
            case quizMain(QuizMainStore.Action)
            case solvedNews(SolvedNewsStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.quizMain, action: /Action.quizMain) {
                QuizMainStore()
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
                                
            case .popToRoot:
                state.path.removeAll()
                return .none
                
            default:
                return .none
            }
        }
        Scope(state: \.main, action: /Action.main) {
            MyPageMainStore()
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
