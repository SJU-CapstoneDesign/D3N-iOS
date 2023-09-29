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
            VStack {
//                HStack {
//                    Text("문제")
//                        .padding()
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Spacer()
//                }
// TODO: navigation bar ROOT APP 단위에서 만들어 불러오기
                    ForEach(viewModel.quizs, id: \.self) { quiz in
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(Color.indigo)
                                .opacity(0.2)
                                .padding()
                        VStack (alignment: .leading){
                            HStack {
                                Text(quiz.question)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                Spacer()
                            }.padding(.top) .padding(.horizontal)
                            VStack (alignment: .center){
                                ForEach(Array(quiz.choiceList.enumerated()), id: \.offset) { index, choice in
                                    ZStack(alignment: .leading){
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundStyle(Color.white)
                                            .opacity(0.9)
                                            .shadow(radius: 3, x: 5, y: 5);                                                   VStack(alignment: .leading){
                                                Text("\(index+1). \(choice)")
                                                    .font(.body)
                                                    .foregroundStyle(index + 1 == quiz.answer ? Color.init(uiColor: .systemGreen) : Color.init(uiColor: .label))
                                                    .fontWeight(index + 1 == quiz.answer ? .bold : .regular)
                                                    .lineLimit(nil)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                    .padding(.horizontal)
                                                    .padding(.vertical, 10)
                                                if(index + 1 == quiz.answer){
                                                    Text("\(quiz.reason)")
                                                        .font(.body)
                                                        .fontWeight(.semibold)
                                                        .foregroundStyle(Color.init(uiColor: .systemGreen))
                                                        .lineLimit(nil)
                                                        .fixedSize(horizontal: false, vertical: true)
                                                        .opacity(0.8)
                                                        .padding(.bottom, 10)
                                                        .padding(.horizontal)
                                                }
                                            }
                                        //TODO: 유저가 고른 정답 == 원래 정답이면 green, 아니면 고른 정답은 red나 pink, 원래 정답은 green로 표현
                                        Spacer()
                                    }
                                }
                            } .padding()
                            
                        }.padding()
                    }
                }
            }
            .padding(5)
        }
        ZStack{
            Button{
                viewModel.send(.rootButtonTapped)
            } label:{
                Text("뉴스 목록으로 돌아가기")
                    .frame(maxWidth: .infinity)
                    .controlSize(.large)
            }
            .tint(.indigo)
            .buttonStyle(.borderedProminent)
            .shadow(radius: 10, x: 4, y: 4)
        }.padding(.leading) .padding(.trailing)
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
