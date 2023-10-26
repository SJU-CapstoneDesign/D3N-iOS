//
//  OnboardingNavigationStackStore.swift
//  D3N
//
//  Created by 송영모 on 10/26/23.
//  Copyright © 2023 sju. All rights reserved.
//

import ComposableArchitecture

public struct OnboardingNavigationStackStore: Reducer {
    public struct State: Equatable {
        var signUp: OnboardingSignUpStore.State = .init()
        
        var path: StackState<Path.State> = .init()
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        
        case signUp(OnboardingSignUpStore.Action)
        case path(StackAction<Path.State, Path.Action>)
        
        case delegate(Delegate)
        
        public enum Delegate {
            case complete
        }
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case nickname(OnboardingNicknameStore.State)
        }
        
        public enum Action: Equatable {
            case nickname(OnboardingNicknameStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.nickname, action: /Action.nickname) {
                OnboardingNicknameStore()
            }
        }
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            default:
                return .none
            }
        }
        Scope(state: \.signUp, action: /Action.signUp) {
            OnboardingSignUpStore()
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
