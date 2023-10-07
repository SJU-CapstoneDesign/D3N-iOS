//
//  QuestionListView.swift
//  D3N
//
//  Created by 송영모 on 10/7/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct QuestionListView: View {
    let store: StoreOf<QuestionListStore>
    
    public init(store: StoreOf<QuestionListStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text("Question List View")
            
            Button("next") {
                viewStore.send(.nextButtonTapped)
            }
        }
    }
}

#Preview {
    QuestionListView(store: .init(initialState: .init()) {
        QuestionListStore()
    })
}
