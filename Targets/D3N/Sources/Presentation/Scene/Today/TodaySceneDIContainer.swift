//
//  TodaySceneDIContainer.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public final class TodaySceneDIContainer: TodayFlowCoordinatorDependencies {
    public init() {
        
    }
    
    public func makeTodayFlowCoordinator() -> TodayFlowCoordinator {
        return TodayFlowCoordinator(dependencies: self)
    }
    
    public func makeTodayHomeViewModel(dependencies: TodayHomeViewModel.Dependencies) -> TodayHomeViewModel {
        return TodayHomeViewModel(dependencies: dependencies, chatUseCase: <#T##ChatUseCaseInterface#>, pointUseCase: <#T##PointUseCaseInterface#>)
    }
    
    public func makeChatViewModel(dependencies: ChatViewModel.Dependencies) -> ChatViewModel {
        let openAIRepository: OPENAIRepositoryInterface = OPENAIRepository()
        let chatUseCase: ChatUseCaseInterface = ChatUseCase(openAIRepository: openAIRepository)
        let pointUseCase: PointUseCaseInterface = PointUseCase()
        
        return .init(
            dependencies: dependencies,
            chatUseCase: chatUseCase,
            pointUseCase: pointUseCase
        )
    }
    
    public func makeChatResultViewModel(
        dependencies: ChatResultViewModel.Dependencies
    ) -> ChatResultViewModel {
        let openAIRepository: OPENAIRepositoryInterface = OPENAIRepository()
        let chatUseCase: ChatUseCaseInterface = ChatUseCase(openAIRepository: openAIRepository)
        let pointUseCase: PointUseCaseInterface = PointUseCase()
        
        return .init(
            dependencies: dependencies,
            chatUseCase: chatUseCase,
            pointUseCase: pointUseCase
        )
    }
}
