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
    
    @State var isPressed: Bool = false
    
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
                            .fontWeight(.semibold)
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
                        withAnimation {
                            isPressed = true
                        }
                    },
                    doubleTapTimeoutout: 1,
                    doubleTapAction: {
                    },
                    longPressTime: 0,
                    longPressAction: {
                    },
                    endAction: {
                        withAnimation {
                            isPressed = false
                        }
                        viewStore.send(.tapped)
                    }
                )
            )
            .padding(10)
            .background(isPressed ? Color.systemGray6 : Color.background)
            .cornerRadius(20)
            .clipped()
            .scaleEffect(isPressed ? 0.95 : 1)
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
