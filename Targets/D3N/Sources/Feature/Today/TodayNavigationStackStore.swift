//
//  TodayNavigationStackStore.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import ComposableArchitecture

public struct TodayNavigationStackStore: Reducer {
    public struct State: Equatable {
        var main: TodayMainStore.State = .init()
        
        var path: StackState<Path.State> = .init()
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        
        case main(TodayMainStore.Action)
        case path(StackAction<Path.State, Path.Action>)
        
        case popToRoot
        case delegate(Delegate)
        
        public enum Delegate {
            case complete
        }
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case detail(TodayDetailStore.State)
            case quizMain(QuizMainStore.State)
        }
        
        public enum Action: Equatable {
            case detail(TodayDetailStore.Action)
            case quizMain(QuizMainStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.detail, action: /Action.detail) {
                TodayDetailStore()
            }
            Scope(state: /State.quizMain, action: /Action.quizMain) {
                QuizMainStore()
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
                case let .select(news):
                    state.path.append(.quizMain(.init(news: news)))
                    return .none
                }
                
            default:
                return .none
            }
        }
        Scope(state: \.main, action: /Action.main) {
            TodayMainStore()
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
