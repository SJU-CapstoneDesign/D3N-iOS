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
            ZStack{
                
            }
            VStack {
//                HStack {
//                    Text("문제")
//                        .padding()
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Spacer()
//                }
// 나중에 navigation bar 따로 만드려고 일단 주석으로 뺌
                ForEach(viewModel.quizs, id: \.self) { quiz in
                    VStack (alignment: .trailing){
                        HStack {
                            Text(quiz.question)
                                .font(.title)
                                .fontWeight(.semibold)
                            Spacer()
                        }.padding(.bottom) .padding(.top)
                        
                        VStack{
                            ForEach(Array(quiz.choiceList.enumerated()), id: \.offset) { index, choice in
                                HStack {
                                    Text("\(index+1). \(choice)")
                                        .font(.body)
                                        .foregroundStyle(index + 1 == quiz.answer ? Color.init(uiColor: .systemIndigo) : Color.init(uiColor: .label))
                                        .fontWeight(index + 1 == quiz.answer ? .bold : .regular)
// 유저가 고른 정답 == 원래 정답이면 green, 아니면 고른 정답은 red나 pink, 원래 정답은 indigo로 표현하고 싶은데 유저 정답 테스트 데이터가 있나?
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        VStack{
            Button{
                viewModel.send(.rootButtonTapped)
            } label:{
                Text("뉴스 목록으로 돌아가기")
                    .frame(maxWidth: .infinity)
                    .controlSize(.large)
                    .shadow(radius: 4, x: 0, y: 4)
            }
            .tint(.indigo)
            .buttonStyle(.borderedProminent)
        }.padding()
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
