//
//  AllNewsView.swift
//  D3N
//
//  Created by Younghoon Ahn on 11/14/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct AllNewsView: View {
    let store: StoreOf<AllNewsStore>
    
    public init(store: StoreOf<AllNewsStore>) {
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
            ForEachStore(self.store.scope(state: \.newsListItems, action: AllNewsStore.Action.newsListItems(id:action:))) {
                NewsListItemCellView(store: $0)
            }
        }
    }
}
