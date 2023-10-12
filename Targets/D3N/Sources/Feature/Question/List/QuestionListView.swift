//
//  QuestionListView.swift
//  D3N
//
//  Created by 송영모 on 10/7/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct QuestionListView: View {
    let store: StoreOf<QuestionListStore>
    
    public init(store: StoreOf<QuestionListStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(alignment: .leading) {
                    headerView(viewStore: viewStore)
                    
                    questionListItemsView(viewStore: viewStore)
                }
            }
        }
    }
    
    private func headerView(viewStore: ViewStoreOf<QuestionListStore>) -> some View {
        HStack {
            Button(action: {
                
            }, label: {
                Label("News", systemImage: "chevron.down")
            })
        }
    }
    
    private func questionListItemsView(viewStore: ViewStoreOf<QuestionListStore>) -> some View {
        VStack {
            ForEachStore(self.store.scope(state: \.questionListItems, action: QuestionListStore.Action.questionListItems(id:action:))) {
                QuestionListItemCellView(store: $0)
            }
        }
    }
}

#Preview {
    QuestionListView(store: .init(initialState: .init()) {
        QuestionListStore()
    })
}
