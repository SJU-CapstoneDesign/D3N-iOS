//
//  QuestionResultView.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

public struct QuestionResultView: View {
    @EnvironmentObject private var todayFlowCoordinator: TodayFlowCoordinator
    
    @StateObject private var viewModel: QuestionResultViewModel
    
    public init(viewModel: QuestionResultViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HStack {
                    Text("문제")
                        .font(.title)
                    
                    Spacer()
                }
                
                ForEach(viewModel.quizs, id: \.self) { quiz in
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
                                        .foregroundStyle(index + 1 == quiz.answer ? Color.init(uiColor: .systemPink) : Color.init(uiColor: .label))
                                        .fontWeight(index + 1 == quiz.answer ? .semibold : .regular)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                
                Button("Root") {
                    viewModel.send(.rootButtonTapped)
                }
            }
            .padding()
        }
        .onReceive(viewModel.$popToRoot) { popToRoot in
            if popToRoot {
                switch viewModel.parent {
                case .today:
                    todayFlowCoordinator.popToRoot()
                }
            }
        }
    }
}
