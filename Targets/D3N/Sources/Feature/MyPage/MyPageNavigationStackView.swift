//
//  MyPageNavigationStackView.swift
//  D3N
//
//  Created by 송영모 on 10/15/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct MyPageNavigationStackView: View {
    let store: StoreOf<MyPageNavigationStackStore>
    
    public init(store: StoreOf<MyPageNavigationStackStore>) {
        self.store = store
    }

    public var body: some View {
        NavigationStackStore(self.store.scope(
            state: \.path,
            action: MyPageNavigationStackStore.Action.path)) {
                WithViewStore(self.store, observe: { $0 }) { viewStore in
                    MyPageMainView(store: self.store.scope(state: \.main, action: MyPageNavigationStackStore.Action.main))
                        .task {
                            viewStore.send(.onAppear)
                        }
                }
            } destination: {
                switch $0 {
                case .quizMain:
                    CaseLet(
                        /MyPageNavigationStackStore.Path.State.quizMain,
                         action: MyPageNavigationStackStore.Path.Action.quizMain,
                         then: QuizMainView.init(store:)
                    )
                case .solvedNews:
                    CaseLet(
                        /MyPageNavigationStackStore.Path.State.solvedNews,
                         action: MyPageNavigationStackStore.Path.Action.solvedNews,
                         then: SolvedNewsView.init(store:)
                    )
                }
            }

    }
}
