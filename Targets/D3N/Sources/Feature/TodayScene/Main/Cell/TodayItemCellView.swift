//
//  TodayItemCellView.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct TodayItemCellView: View {
    let store: StoreOf<TodayItemCellStore>
    
    public init(store: StoreOf<TodayItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.mint)
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewStore.state.news.title)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Text(viewStore.state.news.summary)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                }
                
                Spacer()
                
                Button("풀기", action: {
                    viewStore.send(.tapped)
                })
                .buttonStyle(.bordered)
            }
        }
    }
}
