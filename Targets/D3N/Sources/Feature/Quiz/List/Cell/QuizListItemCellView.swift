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
                questionView(
                    question: viewStore.state.question,
                    reason: viewStore.state.reason,
                    answer: viewStore.state.answer,
                    selectedAnswer: viewStore.state.selectedAnswer,
                    level: viewStore.state.level,
                    isSolved: viewStore.state.isSolved
                )
                .padding(.top, 10)
                
                Spacer()
                
                ForEach(Array(viewStore.choices.enumerated()), id: \.offset) { index, choice in
                    D3NIconAnimationButton(
                        icon: .resolved(index: index, isActive: index == viewStore.state.selectedAnswer),
                        title: choice,
                        isSelected: index == viewStore.state.selectedAnswer
                    ) {
                        viewStore.send(.answered(index), animation: .default)
                    }
                }
                
                D3NSubmitButton(
                    activeTitle: viewStore.state.isSolved ? "이미 제출했습니다." : "제출하기",
                    inactiveTitle: viewStore.state.isSolved ? "이미 제출했습니다." : "답을 선택해주세요",
                    isActive: viewStore.state.isSolved ? true : (viewStore.state.selectedAnswer != nil)
                ) {
                    viewStore.send(.submitButtonTappped)
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    private func questionView(
        question: String,
        reason: String,
        answer: Int,
        selectedAnswer: Int?,
        level: Int,
        isSolved: Bool
    ) -> some View {
        VStack {
            D3NIconTextBox.resolved(number: level)
                .padding(.bottom, 10)
            
            Text(question)
            
            Spacer()
            
            if isSolved {
                if answer == selectedAnswer {
                    D3NIcon(
                        systemImageName: "checkmark.circle.fill",
                        inactiveColor: .green
                    )
                } else {
                    D3NIcon(
                        systemImageName: "xmark.circle.fill",
                        inactiveColor: .pink
                    )
                }
                
                Text(reason)
                    .font(.callout)
                
                Spacer()
            }
        }
    }
}
