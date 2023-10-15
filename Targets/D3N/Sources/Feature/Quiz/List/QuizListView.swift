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
                quizListItemView()
                    .padding()
                
                Spacer()
                
                MinimalButton(title: "완료", isActive: false, action: {
                    viewStore.send(.solvedButtonTapped)
                })
                .padding()
            }
        }
    }
    
    private func quizListItemView() -> some View {
        VStack(spacing: 10) {
            ForEachStore(self.store.scope(state: \.quizListItems, action: QuizListStore.Action.quizListItems(id:action:))) {
                QuizListItemCellView(store: $0)
            }
        }
    }
}
