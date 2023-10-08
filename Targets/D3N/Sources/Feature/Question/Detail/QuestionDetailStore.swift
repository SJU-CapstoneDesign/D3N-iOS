//
//  QuestionDetailStore.swift
//  D3N
//
//  Created by 송영모 on 10/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import ComposableArchitecture

public struct QuestionDetailStore: Reducer {
    public struct State: Equatable { }
    
    public enum Action: Equatable {
        case onAppear
        
        case nextButtonTapped
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case navigateToResult
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .nextButtonTapped:
                return .send(.delegate(.navigateToResult))
                
            default:
                return .none
            }
        }
    }
}

