//
//  QuestionBottomSheetView.swift
//  D3N
//
//  Created by 송영모 on 2023/09/19.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

public struct QuestionBottomSheetView: View {
    @ObservedObject var viewModel: QuestionPassageViewModel
    
    public var body: some View {
        ScrollView {
            VStack {
                headerView()
                
            }
            VStack(spacing: 10) {
                ForEach(quizs, id: \.self) { quiz in
                    QuestionResultView(viewModel: <#T##QuestionResultViewModel#>)
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
    
    private func headerView() -> some View {
        HStack {
            Text("문제")
                .font(.title)
            
            Spacer()
        }
    }
    
    private func quizCellView(quiz: QuizEntity) -> some View {
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
}

