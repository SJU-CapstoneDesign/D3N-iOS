//
//  QuizResultItemCellStore.swift
//  D3N
//
//  Created by 송영모 on 10/15/23.
//  Copyright © 2023 sju. All rights reserved.
//


import Foundation

import ComposableArchitecture

public struct QuizResultItemCellStore: Reducer {
    public struct State: Equatable, Identifiable {
        public var id: UUID
        public var quiz: QuizEntity
        
        public init(
            id: UUID = .init(),
            quiz: QuizEntity
        ) {
            self.id = id
            self.quiz = quiz
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case tapped
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case tapped
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .tapped:
                return .send(.delegate(.tapped))
                
            default:
                return .none
            }
        }
    }
}
