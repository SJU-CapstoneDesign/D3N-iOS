//
//  OnboardingNavigationStackView.swift
//  D3N
//
//  Created by 송영모 on 10/26/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct OnboardingNavigationStackView: View {
    let store: StoreOf<OnboardingNavigationStackStore>
    
    public init(store: StoreOf<OnboardingNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(
            state: \.path,
            action: OnboardingNavigationStackStore.Action.path)
        ) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                OnboardingSignUpView(store: self.store.scope(state: \.signUp, action: OnboardingNavigationStackStore.Action.signUp))
                    .onAppear {
                        viewStore.send(.onAppear)
                    }
            }
        } destination: {
            switch $0 {
            case .nickname:
                CaseLet(
                    /OnboardingNavigationStackStore.Path.State.nickname,
                     action: OnboardingNavigationStackStore.Path.Action.nickname,
                     then: OnboardingNicknameView.init(store:)
                )
            case .userInfo:
                CaseLet(
                    /OnboardingNavigationStackStore.Path.State.userInfo,
                     action: OnboardingNavigationStackStore.Path.Action.userInfo,
                     then: OnboardingUserInfoView.init(store:)
                )
            }
        }
    }
}
