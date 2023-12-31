//
//  SolvedNewsView.swift
//  D3N
//
//  Created by Younghoon Ahn on 11/23/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct SolvedNewsView: View {
    let store: StoreOf<SolvedNewsStore>
    
    public init(store: StoreOf<SolvedNewsStore>) {
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
            .navigationTitle("내가 푼 뉴스")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
    
    private var newsListItemsView: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            if viewStore.state.isEmptyNewsEntityList() {
                return AnyView(
                    Text("아직 풀어본 뉴스가 없어요")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                )
            } else {
                return AnyView(
                    LazyVStack {
                        ForEachStore(self.store.scope(state: \.newsListItems, action: SolvedNewsStore.Action.newsListItems(id:action:))) {
                            NewsListItemCellView(store: $0)
                        }
                    }
                )
            }
        }
    }

}

