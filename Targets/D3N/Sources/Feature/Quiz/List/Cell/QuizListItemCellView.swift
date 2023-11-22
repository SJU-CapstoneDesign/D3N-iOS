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
                questionView(question: viewStore.state.question, answer: viewStore.state.answer, selectedAnswer: viewStore.state.selectedAnswer)
                
                Spacer()
                
                ForEach(Array(viewStore.choices.enumerated()), id: \.offset) { index, choice in
                    D3NIconAnimationButton(
                        icon: .resolved(index: index),
                        title: choice,
                        isSelected: index == viewStore.state.selectedAnswer
                    ) {
                        viewStore.send(.answered(index), animation: .default)
                    }
                }
                
                D3NSubmitButton(
                    activeTitle: "제출하기",
                    inactiveTitle: "답을 선택해주세요",
                    isActive: viewStore.state.selectedAnswer != nil
                ) {
                    viewStore.send(.submitButtonTappped)
                }
                .padding()
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
    
    @ViewBuilder
    private func questionView(
        question: String,
        answer: Int,
        selectedAnswer: Int?
    ) -> some View {
        HStack {
            if let selectedAnswer {
                if answer == selectedAnswer {
                    D3NIcon(
                        systemImageName: "checkmark.circle.fill",
                        color: .green
                    )
                    
                    Text(question)
                        .padding(.top, 40)
                } else {
                    D3NIcon(
                        systemImageName: "xmark.circle.fill",
                        color: .pink
                    )
                    
                    Text(question)
                        .padding(.top, 40)
                }
            }
            
            Text(question)
                .padding(.top, 40)
        }
    }
}
