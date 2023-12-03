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
                    TodayNewsNavigationStackView(store: $0)
                        .tabItem {
                            Image(systemName: "doc.text.image")
                            Text("투데이")
                        }
                }
                
                IfLetStore(self.store.scope(state: \.allNews, action: MainTabStore.Action.allNews)){
                    AllNewsNavigationStackView(store: $0)
                        .tabItem {
                            Image(systemName: "text.justify.left")
                            Text("전체 뉴스")
                        }
                }
                
                IfLetStore(self.store.scope(state: \.myPage, action: MainTabStore.Action.myPage)) {
                    MyPageNavigationStackView(store: $0)
                        .tabItem {
                            Image(systemName: "person.circle")
                            Text("마이")
                        }
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

#Preview {
    MainTabView(store: .init(initialState: .init()) {
        MainTabStore()
    })
}
