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
                IfLetStore(self.store.scope(state: \.today, action: MainTabStore.Action.today)) {
                    TodayNavigationStackView(store: $0)
                        .tabItem {
                            Image(systemName: "doc.text.image")
                            Text("투데이")
                        }
                }
                
                IfLetStore(self.store.scope(state: \.myPage, action: MainTabStore.Action.myPage)) {
                    MyPageNavigationStackView(store: $0)
                        .tabItem {
                            Image(systemName: "person.circle")
                            Text("마이")
                        }
                }
                
//                TodayNavigationStackView(store: self.store.scope(state: \.today, action: MainTabStore.Action.today))
//                    .tabItem {
//                        Image(systemName: "doc.text.image")
//                        Text("투데이")
//                    }
                
//                MyPageNavigationStackView(store: self.store.scope(state: \.myPage, action: MainTabStore.Action.myPage))
//                    .tabItem {
//                        Image(systemName: "person.circle")
//                        Text("마이")
//                    }
            }
        }
    }
}

#Preview {
    MainTabView(store: .init(initialState: .init()) {
        MainTabStore()
    })
}
