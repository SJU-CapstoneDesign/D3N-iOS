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
        
        var today: TodayNewsNavigationStackStore.State? = .init()
        var allNews: AllNewsNavigationStackStore.State? = .init()
        var myPage: MyPageNavigationStackStore.State? = .init()
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        case selectTab(MainScene)
        
        case authRefreshRequest
        case authRefreshResponse(Result<AuthEntity, D3NAPIError>)
        
        case today(TodayNewsNavigationStackStore.Action)
        case allNews(AllNewsNavigationStackStore.Action)
        case myPage(MyPageNavigationStackStore.Action)
        case delegate(Delegate)
        
        public enum Delegate {
            case appleUnlinked
        }
    }
    
    @Dependency(\.authClient) var authClient
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.authRefreshRequest)
                
            case .authRefreshRequest:
                return .run { send in
                    await send(.authRefreshResponse(await authClient.refresh()))
                }
                
            case let .myPage(.delegate(action)):
                switch action {
                case .unlinked:
                    state.today = nil
                    state.myPage = nil
                    return .send(.delegate(.appleUnlinked))
                default:
                    return .none
                }
                
            default:
                return .none
            }
        }
        .ifLet(\.today, action: /Action.today) {
            TodayNewsNavigationStackStore()
        }
        .ifLet(\.allNews, action: /Action.allNews) {
            AllNewsNavigationStackStore()
        }
        .ifLet(\.myPage, action: /Action.myPage) {
            MyPageNavigationStackStore()
        }
    }
}
