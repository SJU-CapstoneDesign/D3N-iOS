//
//  MainTabView.swift
//  Finiens
//
//  Created by 송영모 on 2023/07/26.
//

import SwiftUI

import ComposableArchitecture

struct MainTabView: View {
    let store: StoreOf<MainTabViewStore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView {
                QuestionNavigationStackView(store: self.store.scope(state: \.question, action: { .question($0) }))
            }
        }
    }
}

#Preview {
    MainTabView(store: .init(initialState: .init()) {
        MainTabViewStore()
    })
}
