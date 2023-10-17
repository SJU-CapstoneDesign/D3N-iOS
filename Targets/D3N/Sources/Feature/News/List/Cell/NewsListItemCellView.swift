//
//  NewsListItemCellView.swift
//  D3N
//
//  Created by 송영모 on 10/17/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct NewsListItemCellView: View {
    let store: StoreOf<NewsListItemCellStore>
    
    public init(store: StoreOf<NewsListItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.mint)
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewStore.state.newsEntity.title)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Text(viewStore.state.newsEntity.summary)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                }
                
                Spacer()
                
                Button("풀기", action: {
                    viewStore.send(.tapped)
                })
                .minimalBackgroundStyle()
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
