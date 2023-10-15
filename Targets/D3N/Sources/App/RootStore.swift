//
//  RootStore.swift
//  Finiens
//
//  Created by 송영모 on 2023/07/27.
//

import Foundation

import ComposableArchitecture

struct RootStore: Reducer {

    enum State: Equatable {
        case mainTab(MainTabStore.State)
        
        init() {
            self = .mainTab(.init())
        }
    }
    
    enum Action: Equatable {
        case mainTab(MainTabStore.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            default: return .none
            }
        }
        
        .ifCaseLet(/State.mainTab, action: /Action.mainTab) {
            MainTabStore()
        }
    }
}
