//
//  OnboardingNicknameStore.swift
//  D3N
//
//  Created by 송영모 on 10/26/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct OnboardingNicknameStore: Reducer {
    public struct State: Equatable {
        @BindingState var focus: Field? = .nickname
        @BindingState var nickname: String = ""
        
        var isConfirmButtonActive: Bool = false
        
        public init() { }
        
        enum Field: Hashable {
          case nickname
        }
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case onAppear

        case confirmButtonTapped
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case submit(String)
        }
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding(\.$nickname):
                state.isConfirmButtonActive = !state.nickname.isEmpty
                return .none
                
            case .onAppear:
                state.focus = .nickname
                return .none

            case .confirmButtonTapped:
                if state.isConfirmButtonActive {
                    state.focus = nil
                    return .send(.delegate(.submit(state.nickname)))
                }
                return .none
                
            default:
                return .none
            }
        }
    }
}
