//
//  AllNewsNavigationStackView.swift
//  D3N
//
//  Created by Younghoon Ahn on 11/14/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct AllNewsNavigationStackView: View {
    let store: StoreOf<AllNewsNavigationStackStore>
    
    public init(store: StoreOf<AllNewsNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(
            state: \.path,
            action: AllNewsNavigationStackStore.Action.path)) {
                WithViewStore(self.store, observe: { $0 }) { viewStore in
                    AllNewsView(store: self.store.scope(state: \.main, action: AllNewsNavigationStackStore.Action.main))
                        .onAppear {
                            viewStore.send(.onAppear)
                        }
                }
            } destination: {
                switch $0 {
                case .quizMain:
                    CaseLet(
                        /AllNewsNavigationStackStore.Path.State.quizMain,
                         action: AllNewsNavigationStackStore.Path.Action.quizMain,
                         then: QuizMainView.init(store:)
                    )
                    
                case .quizResult:
                    CaseLet(
                        /AllNewsNavigationStackStore.Path.State.quizResult,
                         action: AllNewsNavigationStackStore.Path.Action.quizResult,
                         then: QuizResultView.init(store:)
                    )
                    
                case .allNews:
                    CaseLet(
                        /AllNewsNavigationStackStore.Path.State.allNews,
                         action: TodayNewsNavigationStackStore.Path.Action.allNews,
                         then: AllNewsView.init(store:)
                    )
                }
            }

    }
}
