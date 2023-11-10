//
//  TodayListItemCellView.swift
//  D3N
//
//  Created by 송영모 on 11/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct TodayListItemCellView: View {
    let store: StoreOf<TodayListItemCellStore>
    
    public init(store: StoreOf<TodayListItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Button(action: {}, label: {
                HStack {
                    viewStore.state.newsEntity.field.icon
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(viewStore.state.newsEntity.title)
                            .font(.headline)
                            .lineLimit(1)
                        
                        Text(viewStore.state.newsEntity.summary)
                            .font(.footnote)
                            .foregroundStyle(.gray)
                            .lineLimit(1)
                    }
                }
            })
            .buttonStyle(
                ScrollViewGestureButtonStyle(
                    pressAction: {
                        print("[D] press")
                    },
                    doubleTapTimeoutout: 1,
                    doubleTapAction: {
                        print("double tap")
                    },
                    longPressTime: 0,
                    longPressAction: {
                        print("long press")
                    },
                    endAction: {
                        print("[D] end")
                    }
                )
            )
//            .task {
//                viewStore.send(.onAppear)
//            }
        }
    }
}
