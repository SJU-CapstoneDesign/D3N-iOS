//
//  TodaySceneDIContainer.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public final class TodaySceneDIContainer: TodayFlowCoordinatorDependencies {
    public init() { }
    
    public func makeTodayFlowCoordinator() -> TodayFlowCoordinator {
        return TodayFlowCoordinator(dependencies: self)
    }
    
    public func makeTodayHomeViewModel(dependencies: TodayHomeViewModel.Dependencies) -> TodayHomeViewModel {
        let newsRepository: NewsRepositoryInterface = NewsRepository()
        let newsUseCase: NewsUseCaseInterface = NewsUseCase(newsRepository: newsRepository)
        
        return TodayHomeViewModel(dependencies: dependencies, newsUseCase: newsUseCase)
    }
    
    public func makeQuestionPassageViewModel(dependencies: QuestionPassageViewModel.Dependencies) -> QuestionPassageViewModel {
        let newsRepository: NewsRepositoryInterface = NewsRepository()
        let newsUseCase: NewsUseCaseInterface = NewsUseCase(newsRepository: newsRepository)
        
        return QuestionPassageViewModel(dependencies: dependencies, newsUseCase: newsUseCase)
    }
    
    public func makeQuestionResultViewModel(dependencies: QuestionResultViewModel.Dependencies) -> QuestionResultViewModel {
        let newsRepository: NewsRepositoryInterface = NewsRepository()
        let newsUseCase: NewsUseCaseInterface = NewsUseCase(newsRepository: newsRepository)
        
        return QuestionResultViewModel(dependencies: dependencies, newsUseCase: newsUseCase)
    }
}
