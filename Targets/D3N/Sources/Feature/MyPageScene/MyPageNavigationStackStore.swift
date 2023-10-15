//
//  MyPageNavigationStackStore.swift
//  D3N
//
//  Created by 송영모 on 10/15/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture

public struct MyPageNavigationStackStore: Reducer {
    public struct State: Equatable {
        var main: MyPageMainStore.State = .init()
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case main(MyPageMainStore.Action)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
        Scope(state: \.main, action: /Action.main) {
            MyPageMainStore()
        }
    }
}
