//
//  OnboardingGenderStore.swift
//  D3N
//
//  Created by 송영모 on 11/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct OnboardingGenderStore: Reducer {
    public struct State: Equatable {
        var gender: Gender?
        
        public init(gender: Gender? = nil) {
            self.gender = gender
        }
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case onAppear

        case genderButtonTapped(Gender)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case submit(Gender)
        }
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
                
            case let .genderButtonTapped(gender):
                state.gender = gender
                return .send(.delegate(.submit(gender)))
                
            default:
                return .none
            }
        }
    }
}
