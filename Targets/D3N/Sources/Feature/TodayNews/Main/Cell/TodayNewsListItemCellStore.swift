//
//  TodayNewsListItemCellStore.swift
//  D3N
//
//  Created by 송영모 on 11/30/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct TodayNewsListItemCellStore: Reducer {
    public struct State: Equatable, Identifiable {
        public var id: UUID
        public var todayNews: TodayNewsEntity
        
        public init(
            id: UUID = .init(),
            todayNews: TodayNewsEntity
        ) {
            self.id = id
            self.todayNews = todayNews
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case tapped
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case onAppear
            case tapped
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.delegate(.onAppear))
                
            case .tapped:
                return .send(.delegate(.tapped))
                
            default:
                return .none
            }
        }
    }
}
