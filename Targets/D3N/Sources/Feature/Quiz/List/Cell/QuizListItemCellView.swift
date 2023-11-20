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

struct QuizChoiceButton: View {
    let choice: String
    let answer: Int
    let userAnswer: Int?
    var action: () -> ()
    
    @State var isPressed: Bool = false
    
    init(
        choice: String,
        answer: Int,
        userAnswer: Int? = nil,
        isPressed: Bool = false,
        action: @escaping () -> ()
    ) {
        self.choice = choice
        self.answer = answer
        self.userAnswer = userAnswer
        self.isPressed = isPressed
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Spacer()
                Text(choice)
                    .fontWeight(.semibold)
                Spacer()
            }
        })
        .buttonStyle(
            ScrollViewGestureButtonStyle(
                pressAction: {
                    withAnimation {
                        isPressed = true
                    }
                },
                doubleTapTimeoutout: 1,
                doubleTapAction: {
                },
                longPressTime: 0,
                longPressAction: {
                },
                endAction: {
                    withAnimation {
                        isPressed = false
                    }
                }
            )
        )
        .padding(10)
        .background(isPressed ? Color.systemGray6 : Color.background)
        .cornerRadius(20)
        .clipped()
        .scaleEffect(isPressed ? 0.95 : 1)
    }
}

public struct QuizListItemCellView: View {
    let store: StoreOf<QuizListItemCellStore>
    
    public init(store: StoreOf<QuizListItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 15) {
                Text(viewStore.state.question)
                
                ForEach(Array(viewStore.choices.enumerated()), id: \.offset) { index, choice in
                    D3NIconAnimationButton(
                        title: choice
                    ) {
                        
                    }
                }
            }
        }
    }
}
