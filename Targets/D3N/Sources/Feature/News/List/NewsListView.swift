//
//  NewsListView.swift
//  D3N
//
//  Created by 송영모 on 10/17/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct NewsListView: View {
    let store: StoreOf<NewsListStore>
    
    public init(store: StoreOf<NewsListStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack {
                    newsListItemsView
                        .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .navigationTitle("전체 뉴스")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
    
    private var newsListItemsView: some View {
        LazyVStack {
            ForEachStore(self.store.scope(state: \.newsListItems, action: NewsListStore.Action.newsListItems(id:action:))) {
                NewsListItemCellView(store: $0)
            }
        }
    }
}
