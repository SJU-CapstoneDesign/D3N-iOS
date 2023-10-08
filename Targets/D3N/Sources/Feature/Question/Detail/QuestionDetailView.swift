//
//  QuestionDetailView.swift
//  D3N
//
//  Created by 송영모 on 10/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct QuestionDetailView: View {
    let store: StoreOf<QuestionDetailStore>
    
    public init(store: StoreOf<QuestionDetailStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text("Question Detail View")
            
            Button("next") {
                viewStore.send(.nextButtonTapped)
            }
        }
    }
}

#Preview {
    QuestionDetailView(store: .init(initialState: .init()) {
        QuestionDetailStore()
    })
}
