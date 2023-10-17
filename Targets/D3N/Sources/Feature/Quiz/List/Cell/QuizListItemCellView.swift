//
//  QuizListItemCellView.swift
//  D3N
//
//  Created by 송영모 on 10/14/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct QuizListItemCellView: View {
    let store: StoreOf<QuizListItemCellStore>
    
    public init(store: StoreOf<QuizListItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                titleView(viewStore: viewStore)
                
                choiceListItemView()
            }
            .padding(10)
            .background(Color(uiColor: .systemGray6))
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                )
            )
        }
    }
    
    private func titleView(viewStore: ViewStoreOf<QuizListItemCellStore>) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewStore.state.quizEntity.question)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
            }
        }
    }
    
    private func choiceListItemView() -> some View {
        ForEachStore(self.store.scope(state: \.choiceListItems, action: QuizListItemCellStore.Action.choiceListItems(id:action:))) {
            ChoiceListItemCellView(store: $0)
        }
    }
}
