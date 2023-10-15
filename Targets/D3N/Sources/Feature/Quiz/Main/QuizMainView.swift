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
                WebView(url: viewStore.state.news.url)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            viewStore.send(.solveButtonTapped)
                        }, label: {
                            Label("풀기", systemImage: "pencil")
                        })
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
            }
            .sheet(
                store: self.store.scope(
                    state: \.$quizList,
                    action: { .quizList($0) }
                )
            ) {
                QuizListView(store: $0)
            }
            .toolbar(.hidden, for: .tabBar)
        }
    }
}
