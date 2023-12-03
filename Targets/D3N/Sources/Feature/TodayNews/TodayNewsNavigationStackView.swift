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

public struct TodayNewsNavigationStackView: View {
    let store: StoreOf<TodayNewsNavigationStackStore>
    
    public init(store: StoreOf<TodayNewsNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(
            state: \.path,
            action: TodayNewsNavigationStackStore.Action.path)) {
                WithViewStore(self.store, observe: { $0 }) { viewStore in
                    TodayNewsMainView(store: self.store.scope(state: \.main, action: TodayNewsNavigationStackStore.Action.main))
                        .task {
                            viewStore.send(.onAppear)
                        }
                }
            } destination: {
                switch $0 {
                case .quizMain:
                    CaseLet(
                        /TodayNewsNavigationStackStore.Path.State.quizMain,
                         action: TodayNewsNavigationStackStore.Path.Action.quizMain,
                         then: QuizMainView.init(store:)
                    )
                    
                case .allNews:
                    CaseLet(
                        /TodayNewsNavigationStackStore.Path.State.allNews,
                         action: TodayNewsNavigationStackStore.Path.Action.allNews,
                         then: AllNewsView.init(store:)
                    )
                }
            }

    }
}
