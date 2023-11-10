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
        case onboarding(OnboardingNavigationStackStore.State)
        case mainTab(MainTabStore.State)
        
        init() {
            if LocalStorageManager.load(.isOnBoardingNeeded) != false {
                self = .onboarding(.init())
            } else {
                self = .mainTab(.init())
            }
        }
    }
    
    enum Action: Equatable {
        case onAppear
        
        case onboarding(OnboardingNavigationStackStore.Action)
        case mainTab(MainTabStore.Action)
        
        case navigateOnboarding
        case navigateMainTab
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onboarding(.delegate(.complete)):
                return .send(.navigateMainTab)
                
            case let .mainTab(.delegate(action)):
                switch action {
                case .appleUnlinked:
                    return .send(.navigateOnboarding)
                }
                
            case .navigateOnboarding:
                state = .onboarding(.init())
                return .none
                
            case .navigateMainTab:
                state = .mainTab(.init())
                return .none
                
            default:
                return .none
            }
        }
        .ifCaseLet(/State.onboarding, action: /Action.onboarding) {
            OnboardingNavigationStackStore()
        }
        .ifCaseLet(/State.mainTab, action: /Action.mainTab) {
            MainTabStore()
        }
    }
}
