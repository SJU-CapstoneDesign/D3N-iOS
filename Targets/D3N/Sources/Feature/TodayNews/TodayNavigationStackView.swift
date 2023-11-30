//
//  TodayNavigationStackView.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct TodayNavigationStackView: View {
    let store: StoreOf<TodayNavigationStackStore>
    
    public init(store: StoreOf<TodayNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(
            state: \.path,
            action: TodayNavigationStackStore.Action.path)) {
                WithViewStore(self.store, observe: { $0 }) { viewStore in
                    TodayMainView(store: self.store.scope(state: \.main, action: TodayNavigationStackStore.Action.main))
                        .task {
                            viewStore.send(.onAppear)
                        }
                }
            } destination: {
                switch $0 {
                case .detail:
                    CaseLet(
                        /TodayNavigationStackStore.Path.State.detail,
                         action: TodayNavigationStackStore.Path.Action.detail,
                         then: TodayDetailView.init(store:)
                    )
                    
                case .quizMain:
                    CaseLet(
                        /TodayNavigationStackStore.Path.State.quizMain,
                         action: TodayNavigationStackStore.Path.Action.quizMain,
                         then: QuizMainView.init(store:)
                    )
                    
                case .quizResult:
                    CaseLet(
                        /TodayNavigationStackStore.Path.State.quizResult,
                         action: TodayNavigationStackStore.Path.Action.quizResult,
                         then: QuizResultView.init(store:)
                    )
                    
                case .allNews:
                    CaseLet(
                        /TodayNavigationStackStore.Path.State.allNews,
                         action: TodayNavigationStackStore.Path.Action.allNews,
                         then: AllNewsView.init(store:)
                    )
                }
            }

    }
}
