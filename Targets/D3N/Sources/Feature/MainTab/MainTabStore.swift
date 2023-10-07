//
//  MainTabStore.swift
//  Finiens
//
//  Created by 송영모 on 2023/07/26.
//

import Foundation

import ComposableArchitecture

enum MainScene: Hashable {
    case question
}

struct MainTabViewStore: Reducer {

    struct State: Equatable {
        var currentScene: MainScene = .question
        var question: QuestionNavigationStackStore.State = .init()
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case selectTab(MainScene)
        
        case question(QuestionNavigationStackStore.Action)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            default: return .none
            }
        }
        
        Scope(state: \.question, action: /Action.question) {
            QuestionNavigationStackStore()
        }
    }
}
