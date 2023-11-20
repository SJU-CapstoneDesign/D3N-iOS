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
            VStack(alignment: .leading) {
                D3NProgressBar(
                    progress: viewStore.state.quizListItems.map { $0.quizEntity.answer == $0.quizEntity.userAnswer },
                    currentIndex: viewStore.state.currentIndex
                )
                .padding(.horizontal)
                
                quizListItemView(
                    tab: viewStore.binding(get: \.currentTab, send: QuizListStore.Action.setTab)
                )
                
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
    
    private func titleView(current: Int, whole: Int) -> some View {
        Text("\(current + 1) / \(whole)")
            .font(.title)
            .fontWeight(.semibold)
            .padding([.top, .horizontal])
    }
    
    private func quizListItemView(tab: Binding<UUID>) -> some View {
        TabView(selection: tab) {
            ForEachStore(self.store.scope(state: \.quizListItems, action: QuizListStore.Action.quizListItems(id:action:))) {
                QuizListItemCellView(store: $0)
                    .padding(.horizontal)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

#Preview {
    QuizListView(store: .init(initialState: QuizListStore.State(quizEntityList: []), reducer: { QuizListStore() }))
}
