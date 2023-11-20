//
//  QuizListItemCellView.swift
//  D3N
//
//  Created by 송영모 on 10/14/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct QuizListItemCellView: View {
    let store: StoreOf<QuizListItemCellStore>
    
    public init(store: StoreOf<QuizListItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text(viewStore.state.question)
                    .padding(.top, 40)
                
                Spacer()
                
                ForEach(Array(viewStore.choices.enumerated()), id: \.offset) { index, choice in
                    D3NIconAnimationButton(
                        icon: .resolved(index: index),
                        title: choice,
                        isSelected: index == viewStore.state.userAnswer
                    ) {
                        viewStore.send(.answered(index), animation: .default)
                    }
                }
                
                D3NSubmitButton(
                    activeTitle: "제출하기",
                    inactiveTitle: "답을 선택해주세요",
                    isActive: viewStore.state.userAnswer != nil
                ) {
                    viewStore.send(.submitButtonTappped)
                }
                .padding()
            }
        }
    }
}
