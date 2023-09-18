//
//  TodayHomeViewModel.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import Combine

public class TodayHomeViewModel: ObservableObject {
    private var subscribers: Set<AnyCancellable> = []
    
    public struct Dependencies: Hashable {
        public init() { }
    }
    
    enum Action { 
        case onAppear
        case nextButtonTapped
    }
    
    private let dependencies: Dependencies
    private let newsUseCase: NewsUseCaseInterface
    
    @Published var newsList: [NewsEntity] = []
    
    @Published var questionPassageDependencies: QuestionPassageViewModel.Dependencies?
    
    public init(
        dependencies: Dependencies,
        newsUseCase: NewsUseCaseInterface
    ) {
        self.dependencies = dependencies
        self.newsUseCase = newsUseCase
        
        bind()
    }
    
    @MainActor
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            Task {
                newsList = try await newsUseCase.fetch().get()
            }
        case .nextButtonTapped:
            questionPassageDependencies = .init(parent: .today)
        }
    }
    
    func bind() {
        
    }
}
