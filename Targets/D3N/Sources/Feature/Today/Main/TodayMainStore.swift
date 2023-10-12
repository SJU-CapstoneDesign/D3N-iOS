//
//  TodayMainStore.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct TodayMainStore: Reducer {
    public struct State: Equatable {
        var todayItems: IdentifiedArrayOf<TodayItemCellStore.State> = [
            .init(), .init(), .init(), .init(), .init(), .init(), .init()
        ]
        
        public init() { }
        
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case todayItems(id: TodayItemCellStore.State.ID, action: TodayItemCellStore.Action)
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

