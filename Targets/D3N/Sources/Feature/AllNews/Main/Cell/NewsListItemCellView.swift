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
                newsLogoView(url: viewStore.state.newsEntity.mediaCompanyLogo, isAlreadySolved: false)
                
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
                .foregroundStyle(Color.blue)
                .minimalBackgroundStyle()
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
    
    private func newsLogoView(url: String, isAlreadySolved: Bool) -> some View {
        ZStack {
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .frame(width: 40, height: 40)
            } placeholder: {
                ProgressView().progressViewStyle(.circular)
            }
            .frame(width: 40, height: 40)
            
            if isAlreadySolved {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
                    .backgroundStyle(.background)
                    .frame(width: 15, height: 15)
                    .offset(x: 15, y: -15)
            }
        }
    }
}
