//
//  OnboardingBirthStore.swift
//  D3N
//
//  Created by 송영모 on 11/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct OnboardingBirthStore: Reducer {
    public struct State: Equatable {
        var birthDate: Date?
        
        public init(birthDate: Date? = nil) {
            self.birthDate = birthDate
        }
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case onAppear

        case setBirthDate(Date)
        case birthDateButtonTapped
        case comfirmButtonTapped
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case confirm(Date)
        }
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case let .setBirthDate(date):
                state.birthDate = date
                return .none
                
            case .comfirmButtonTapped:
                if let date = state.birthDate {
                    return .send(.delegate(.confirm(date)))
                } else {
                    return .none
                }
                
            default:
                return .none
            }
        }
    }
}
