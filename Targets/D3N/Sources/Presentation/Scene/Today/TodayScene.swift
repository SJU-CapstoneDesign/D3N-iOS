//
//  TodayScene.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

import AppTrackingTransparency

public struct TodayScene: View {
    @StateObject private var flowCoordinator: TodayFlowCoordinator
    
    private let sceneDIContainer: TodaySceneDIContainer
    
    public init(sceneDIContainer: TodaySceneDIContainer) {
        self.sceneDIContainer = sceneDIContainer
        self._flowCoordinator = .init(
            wrappedValue: sceneDIContainer.makeTodayFlowCoordinator()
        )
    }
    
    public var body: some View {
        NavigationStack(path: $flowCoordinator.path) {
            TodayHomeView(viewModel: sceneDIContainer.makeTodayHomeViewModel(dependencies: .init()))
                .environmentObject(flowCoordinator)
                .navigationDestination(for: TodayFlowCoordinator.Scene.self) { scene in
                    switch scene {
                    case let .questionPassage(dependencies):
                        QuestionPassageView(viewModel: sceneDIContainer.makeQuestionPassageViewModel(dependencies: dependencies))
                            .environmentObject(flowCoordinator)
                    case let .questionResult(dependencies):
                        QuestionResultView(viewModel: sceneDIContainer.makeQuestionResultViewModel(dependencies: dependencies))
                            .environmentObject(flowCoordinator)
                    }
                }
        }
    }
}

#Preview {
    TodayScene(sceneDIContainer: AppDIContainer().makeTodaySceneDIContainer())
}
