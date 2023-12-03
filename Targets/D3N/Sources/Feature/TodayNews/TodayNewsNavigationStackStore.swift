//
//  TodayNavigationStackStore.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import ComposableArchitecture

public struct TodayNewsNavigationStackStore: Reducer {
    public struct State: Equatable {
        var main: TodayNewsMainStore.State = .init()
        
        var path: StackState<Path.State> = .init()
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        
        case main(TodayNewsMainStore.Action)
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
            case allNews(AllNewsStore.State)
        }
        
        public enum Action: Equatable {
            case quizMain(QuizMainStore.Action)
            case allNews(AllNewsStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.quizMain, action: /Action.quizMain) {
                QuizMainStore()
            }
            Scope(state: /State.allNews, action: /Action.allNews) {
                AllNewsStore()
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
                case .allNewsButtonTapped:
                    state.path.append(.allNews(.init()))
                    return .none
                }
                
            case let .path(.element(id: _, action: .allNews(.delegate(action)))):
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
            TodayNewsMainStore()
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
