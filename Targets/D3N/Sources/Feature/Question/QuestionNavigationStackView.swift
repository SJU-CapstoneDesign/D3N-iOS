//
//  QuestionNavigationStackView.swift
//  D3N
//
//  Created by 송영모 on 10/7/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct QuestionNavigationStackView: View {
    let store: StoreOf<QuestionNavigationStackStore>
    
    public var body: some View {
        NavigationStackStore(self.store.scope(
            state: \.path,
            action: QuestionNavigationStackStore.Action.path)) {
                WithViewStore(self.store, observe: { $0 }) { viewStore in
                    QuestionListView(store: self.store.scope(state: \.list, action: QuestionNavigationStackStore.Action.list))
                        .onAppear {
                            viewStore.send(.onAppear)
                        }
                }
            } destination: {
                switch $0 {
                case .detail:
                    CaseLet(
                        /QuestionNavigationStackStore.Path.State.detail,
                         action: QuestionNavigationStackStore.Path.Action.detail,
                         then: QuestionDetailView.init(store:)
                    )
                case .result:
                    CaseLet(
                        /QuestionNavigationStackStore.Path.State.result,
                         action: QuestionNavigationStackStore.Path.Action.result,
                         then: QuestionResultView.init(store:)
                    )
                }
            }
    }
}
