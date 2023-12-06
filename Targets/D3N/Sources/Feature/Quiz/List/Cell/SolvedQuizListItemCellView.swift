//
//  SolvedQuizListItemCellView.swift
//  D3N
//
//  Created by Younghoon Ahn on 12/1/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct SolvedQuizListItemCellView: View {
    let store: StoreOf<SolvedQuizListItemCellStore>
    
    public init(store: StoreOf<SolvedQuizListItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text(viewStore.state.question)
                    .padding(.top, 40)
                
                Spacer()
                
                ForEach(Array(viewStore.choices.enumerated()), id: \.offset) { index, choice in
                    VStack{
                        Text("Hello123")
                    }
                }
                .padding()
            }
        }
    }
}
