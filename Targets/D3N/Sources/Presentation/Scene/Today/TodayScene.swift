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
    private let sceneDIContainer: TodaySceneDIContainer
    
    @StateObject private var flowCoordinator: TodayFlowCoordinator
    
    public init(sceneDIContainer: TodaySceneDIContainer) {
        self.sceneDIContainer = sceneDIContainer
        self._flowCoordinator = .init(
            wrappedValue: sceneDIContainer.makeTodayFlowCoordinator()
        )
    }
    
    public var body: some View {
        NavigationStack(path: $flowCoordinator.path) {
            TodayHomeView(viewModel: sceneDIContainer.makeTodayHomeViewModel(dependencies: .init()))
//            ChatView(viewModel: sceneDIContainer.makeChatViewModel(dependencies: .init()))
//                .environmentObject(flowCoordinator)
//                .navigationDestination(for: TodayFlowCoordinator.Scene.self) { scene in
//                    switch scene {
//                    case let .chatResult(dependencies):
//                        ChatResultView(
//                            viewModel: chatSceneDIContainer.makeChatResultViewModel(dependencies: dependencies)
//                        )
//                        .environmentObject(chatFlowCoordinator)
//                    }
//                }
        }
    }
}

#Preview {
    TodayScene(sceneDIContainer: AppDIContainer().makeTodaySceneDIContainer())
}
