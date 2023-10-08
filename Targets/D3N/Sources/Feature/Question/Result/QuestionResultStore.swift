//
//  QuestionResultStore.swift
//  D3N
//
//  Created by 송영모 on 10/7/23.
//  Copyright © 2023 sju. All rights reserved.
//

import ComposableArchitecture

public struct QuestionResultStore: Reducer {
    public struct State: Equatable { }
    
    public enum Action: Equatable {
        case onAppear
        case popToRootButtonTapped
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case popToRoot
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .popToRootButtonTapped:
                return .send(.delegate(.popToRoot))
                
            default:
                return .none
            }
        }
    }
}

