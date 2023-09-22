//
//  QuestionBottomSheetView.swift
//  D3N
//
//  Created by 송영모 on 2023/09/19.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

public struct QuestionBottomSheetView: View {
    public let quizs: [QuizEntity]
    public var nextButtonTappedAction: () -> Void
    
    public init(
        quizs: [QuizEntity], 
        nextButtonTappedAction: @escaping () -> Void
    ) {
        self.quizs = quizs
        self.nextButtonTappedAction = nextButtonTappedAction
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HStack {
                    Text("문제")
                        .font(.title)
                    
                    Spacer()
                }
                
                ForEach(quizs, id: \.self) { quiz in
                    VStack {
                        HStack {
                            Text(quiz.question)
                                .font(.headline)
                            Spacer()
                        }
                        
                        VStack {
                            ForEach(Array(quiz.choiceList.enumerated()), id: \.offset) { index, choice in
                                HStack {
                                    Text("\(index+1). \(choice)")
                                        .font(.body)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                
                Button("Next") {
                    nextButtonTappedAction()
                }
            }
            .padding()
        }
    }
}

