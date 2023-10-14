//
//  TodayMainView.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct TodayMainView: View {
    let store: StoreOf<TodayMainStore>
    
    public init(store: StoreOf<TodayMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack {
                    todayNewsView(viewStore: viewStore)
                        .padding()
                }
            }
            .onAppear {
                viewStore.send(.onAppear, animation: .default)
            }
            .navigationTitle("Today")
        }
    }
    
    private func todayNewsView(viewStore: ViewStoreOf<TodayMainStore>) -> some View {
        VStack(alignment: .leading) {
            Text("최신 뉴스를 가져왔어요")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .fontWeight(.semibold)
            
            Text("오늘 풀어야 할 뉴스 \(viewStore.state.todayItems.count) 문제")
                .font(.title)
                .fontWeight(.semibold)
            
            ForEachStore(self.store.scope(state: \.todayItems, action: TodayMainStore.Action.todayItems(id:action:))) {
                TodayItemCellView(store: $0)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .clipped()
        .shadow(color: Color(uiColor: .systemGray5), radius: 20)
    }
}
