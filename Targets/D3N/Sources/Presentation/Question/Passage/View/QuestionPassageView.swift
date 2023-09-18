//
//  QuestionPassageView.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

public struct QuestionPassageView: View {
    @EnvironmentObject private var todayFlowCoordinator: TodayFlowCoordinator
    
    @StateObject private var viewModel: QuestionPassageViewModel
    
    public init(viewModel: QuestionPassageViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                if let url = URL(string: "https://n.news.naver.com/mnews/article/214/0001300292?sid=102") {
                    WebView(url: url)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button("GO TO RESULT") {
                            viewModel.send(.nextButtonTapped)
                        }
                        .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.top)
                    .background(.black)
                    .frame(width: proxy.size.width, height: 80)
                }
                .ignoresSafeArea()
            }
        }
        .onReceive(viewModel.$questionResultDependenices) { dependenciesOrNil in
            if let dependencies =  dependenciesOrNil {
                switch viewModel.dependencies.parent {
                case .today:
                    todayFlowCoordinator.navigate(.questionResult(dependencies))
                }
            }
        }
    }
}
