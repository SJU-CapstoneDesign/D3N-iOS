//
//  OnboardingSignUpStore.swift
//  D3N
//
//  Created by 송영모 on 10/26/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct OnboardingSignUpStore: Reducer {
    public struct State: Equatable {
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear

        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case select(NewsEntity)
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            default:
                return .none
            }
        }
    }
}
