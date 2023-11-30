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

public struct TodayNewsMainView: View {
    let store: StoreOf<TodayNewsMainStore>

    public init(store: StoreOf<TodayNewsMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack {
                    ForEachStore(self.store.scope(state: \.todayNewsListItems, action: TodayNewsMainStore.Action.todayNewsListItems(id:action:))) {
                        TodayNewsListItemCellView(store: $0)
                            .padding()
                    }
                }
            }
            .onAppear {
                viewStore.send(.onAppear, animation: .default)
            }
            .navigationTitle("Today")
        }
    }
}
