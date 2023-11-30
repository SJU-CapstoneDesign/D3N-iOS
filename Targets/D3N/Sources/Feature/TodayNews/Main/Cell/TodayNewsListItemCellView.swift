//
//  TodayNewsListItemCellView.swift
//  D3N
//
//  Created by 송영모 on 11/30/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct TodayNewsListItemCellView: View {
    let store: StoreOf<TodayNewsListItemCellStore>
    
    @State var isPressed: Bool = false
    
    public init(store: StoreOf<TodayNewsListItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: .zero) {
                VStack(alignment: .leading) {
                    Text(viewStore.state.todayNews.title)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text(viewStore.state.todayNews.subtitle)
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                }
                .padding([.horizontal, .top])
                
                VStack(alignment: .leading, spacing: .zero) {
                    ForEach(viewStore.state.todayNews.newses, id: \.self) { news in
                        D3NIconAnimationButton(
                            icon: news.field.icon,
                            title: news.title,
                            content: news.summary,
                            isSelected: false,
                            action: {
                                viewStore.send(.select(news))
                            }
                        )
                    }
                }
                .padding(.bottom, 10)
            }
            .background(Color.background)
            .cornerRadius(20)
            .clipped()
            .shadow(color: .systemGray5, radius: 20)
        }
    }
}
