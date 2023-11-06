//
//  OnboardingNewsFieldStore.swift
//  D3N
//
//  Created by 송영모 on 11/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct OnboardingNewsFieldStore: Reducer {
    public struct State: Equatable {
        var newsFields: [NewsField] = []
        
        public init() {
            
        }
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case onAppear
        
        case selectNewsField(NewsField)
        case submitButtonTapped

        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case submit([NewsField])
        }
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case let .selectNewsField(newsField):
                if let index = state.newsFields.firstIndex(of: newsField){
                    state.newsFields.remove(at: index)
                } else {
                    state.newsFields.append(newsField)
                }
                return .none
                
            case .submitButtonTapped:
                if !state.newsFields.isEmpty {
                    return .send(.delegate(.submit(state.newsFields)))
                } else {
                    return .none
                }
            default:
                return .none
            }
        }
    }
}
