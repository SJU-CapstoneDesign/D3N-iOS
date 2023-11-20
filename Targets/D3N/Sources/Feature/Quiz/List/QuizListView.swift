//
//  QuizListView.swift
//  D3N
//
//  Created by 송영모 on 10/14/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct QuizListView: View {
    let store: StoreOf<QuizListStore>
    
    public init(store: StoreOf<QuizListStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                D3NProgressBar(
                    items: viewStore.state.quizEntityList.map {
                        return .init(secondTime: $0.secondTime)
                    },
                    currentIndex: viewStore.state.currentIndex
                )
                .padding([.horizontal, .top])
                
                TabView(
                    selection: viewStore.binding(
                        get: \.currentTab,
                        send: QuizListStore.Action.setTab
                    )
                ) {
                    ForEachStore(
                        self.store.scope(
                            state: \.quizListItems,
                            action: QuizListStore.Action.quizListItems(id:action:)
                        )
                    ) {
                        QuizListItemCellView(store: $0)
                            .padding(.horizontal)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                Spacer()
                
                D3NSubmitButton(
                    activeTitle: "제출하기",
                    inactiveTitle: "답을 선택해주세요",
                    isActive: viewStore.state.isActive
                ) {
                    viewStore.send(.solvedButtonTapped)
                }
                .padding()
            }
        }
    }
}

#Preview {
    QuizListView(store: .init(initialState: QuizListStore.State(quizEntityList: []), reducer: { QuizListStore() }))
}
