//
//  QuestionResultView.swift
//  D3N
//
//  Created by 송영모 on 10/7/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct QuestionResultView: View {
    let store: StoreOf<QuestionResultStore>
    
    public init(store: StoreOf<QuestionResultStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text("Question Result View")
            
            Button("back to root") {
                viewStore.send(.popToRootButtonTapped)
            }
        }
    }
}

#Preview {
    QuestionResultView(store: .init(initialState: .init()) {
        QuestionResultStore()
    })
}
