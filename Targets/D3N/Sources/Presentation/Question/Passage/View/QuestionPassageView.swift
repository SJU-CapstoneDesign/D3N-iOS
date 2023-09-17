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
        VStack {
            Button("Passage") {
                viewModel.send(.nextButtonTapped)
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
