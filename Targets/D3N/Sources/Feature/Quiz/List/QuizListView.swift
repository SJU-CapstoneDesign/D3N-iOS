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
                    items: viewStore.state.quizs.map {
                        return .init(description: $0.timeString)
                    },
                    currentIndex: viewStore.state.currentTab
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
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

#Preview {
    QuizListView(store: .init(initialState: QuizListStore.State(quizs: []), reducer: { QuizListStore() }))
}
