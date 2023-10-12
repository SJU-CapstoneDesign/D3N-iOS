//
//  QuestionListItemCellStore.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct QuestionListItemCellStore: Reducer {
    public struct State: Equatable, Identifiable {
        public let id: UUID
        
        public init(id: UUID = .init()) {
            self.id = id
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
                return .send(.tapped)
                
            default:
                return .none
            }
        }
    }
}
