//
//  SolvedQuizListView.swift
//  D3N
//
//  Created by Younghoon Ahn on 11/23/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct SolvedNewsNavgationStackView: View {
    let store: StoreOf<SolvedNewsNavigationStackStore>
    
    public init(store: StoreOf<SolvedNewsNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(
            state: \.path,
            action: SolvedNewsNavigationStackStore.Action.path)) {
                WithViewStore(self.store, observe: { $0 }) { viewStore in
                    SolvedNewsView(store: self.store.scope(state: \.main, action: SolvedNewsNavigationStackStore.Action.main))
                        .onAppear {
                            viewStore.send(.onAppear)
                        }
                }
            } destination: {
                switch $0 {
                case .quizMain:
                    CaseLet(
                        /SolvedNewsNavigationStackStore.Path.State.quizMain,
                         action: SolvedNewsNavigationStackStore.Path.Action.quizMain,
                         then: QuizMainView.init(store:)
                    )
                    
                case .quizResult:
                    CaseLet(
                        /SolvedNewsNavigationStackStore.Path.State.quizResult,
                         action: SolvedNewsNavigationStackStore.Path.Action.quizResult,
                         then: QuizResultView.init(store:)
                    )
                    
                case .solvedNews:
                    CaseLet(
                        /SolvedNewsNavigationStackStore.Path.State.solvedNews,
                         action: MyPageNavigationStackStore.Path.Action.solvedNews,
                         then: SolvedNewsView.init(store:)
                    )
                }
            }

    }
}
