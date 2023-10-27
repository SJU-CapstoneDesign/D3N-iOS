//
//  QuizMainView.swift
//  D3N
//
//  Created by 송영모 on 10/14/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct QuizMainView: View {
    let store: StoreOf<QuizMainStore>
    
    public init(store: StoreOf<QuizMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                WebView(url: viewStore.state.newsEntity.url)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button("풀기", action: {
                            viewStore.send(.solveButtonTapped)
                        })
                        .minimalBackgroundStyle()
                    }
                }
                .padding()
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .sheet(
                store: self.store.scope(
                    state: \.$quizList,
                    action: { .quizList($0) }
                )
            ) {
                QuizListView(store: $0)
                    .presentationDetents([.medium])
            }
            .toolbar(.hidden, for: .tabBar)
        }
    }
}
