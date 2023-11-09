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

struct MainTabStore: Reducer {
    struct State: Equatable {
        var currentScene: MainScene = .question
        
        var today: TodayNavigationStackStore.State? = .init()
        var myPage: MyPageNavigationStackStore.State? = .init()
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case selectTab(MainScene)
        
        case today(TodayNavigationStackStore.Action)
        case myPage(MyPageNavigationStackStore.Action)
        case delegate(Delegate)
        
        public enum Delegate {
            case appleUnlinked
        }
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case let .myPage(.delegate(action)):
                switch action {
                case .unlinked:
                    return .send(.delegate(.appleUnlinked))
                }
            default:
                return .none
            }
        }
        .ifLet(\.today, action: /Action.today) {
            TodayNavigationStackStore()
        }
        .ifLet(\.myPage, action: /Action.myPage) {
            MyPageNavigationStackStore()
        }
    }
}
