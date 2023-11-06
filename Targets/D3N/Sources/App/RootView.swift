//
//  RootView.swift
//  Finiens
//
//  Created by 송영모 on 2023/07/27.
//

import SwiftUI

import ComposableArchitecture

struct RootView: View {
    let store: StoreOf<RootStore>
    
    var body: some View {
        SwitchStore(self.store) {
            switch $0 {
            case .onboarding:
                CaseLet(/RootStore.State.onboarding, action: RootStore.Action.onboarding) {
                    OnboardingNavigationStackView(store: $0)
                }
            case .mainTab:
                CaseLet(/RootStore.State.mainTab, action: RootStore.Action.mainTab) {
                    MainTabView(store: $0)
                }
            }
        }
    }
}

#Preview {
    RootView(store: .init(initialState: .init()) {
        RootStore()
    })
}
