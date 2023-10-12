//
//  MainTabView.swift
//  Finiens
//
//  Created by 송영모 on 2023/07/26.
//

import SwiftUI

import ComposableArchitecture

struct MainTabView: View {
    let store: StoreOf<MainTabStore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView {
                TodayNavigationStackView(store: self.store.scope(state: \.today, action: MainTabStore.Action.today))
                    .tabItem {
                        Image(systemName: "doc.text.image")
                        Text("투데이")
                    }
                
                //FIXME: 우선 제거
                QuestionNavigationStackView(store: self.store.scope(state: \.question, action: { .question($0) }))
                    .tabItem {
                        Image(systemName: "")
                    }
            }
        }
    }
}

#Preview {
    MainTabView(store: .init(initialState: .init()) {
        MainTabStore()
    })
}
