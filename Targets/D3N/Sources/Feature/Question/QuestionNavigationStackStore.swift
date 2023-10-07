//
//  QuestionNavigationStackStore.swift
//  D3N
//
//  Created by 송영모 on 10/7/23.
//  Copyright © 2023 sju. All rights reserved.
//

import ComposableArchitecture

struct QuestionNavigationStackStore: Reducer {
    struct State: Equatable {
        var list: QuestionListStore.State = .init()
        var path: StackState<Path.State> = .init()
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        
        case list(QuestionListStore.Action)
        case path(StackAction<Path.State, Path.Action>)
        
        case popToRoot
        case delegate(Delegate)
        
        enum Delegate {
            case complete
        }
    }
    
    struct Path: Reducer {
        public enum State: Equatable {
            case detail(QuestionDetailStore.State)
            case result(QuestionResultStore.State)
        }
        
        public enum Action: Equatable {
            case detail(QuestionDetailStore.Action)
            case result(QuestionResultStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.detail, action: /Action.detail) {
                QuestionDetailStore()
            }
            Scope(state: /State.result, action: /Action.result) {
                QuestionResultStore()
            }
        }
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .list(.delegate(.navigateToDetail)):
                state.path.append(.detail(.init()))
                return .none
                
            case let .path(action):
                switch action {
                case .element(id: _, action: .detail(.delegate(.navigateToResult))):
                    state.path.append(.result(.init()))
                    return .none
                    
                case .element(id: _, action: .result(.delegate(.popToRoot))):
                    return .send(.popToRoot)
                    
                default:
                    return .none
                }
                
            case .popToRoot:
                state.path.removeAll()
                return .none
                
            default:
                return .none
            }
        }
        Scope(state: \.list, action: /Action.list) {
            QuestionListStore()
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
