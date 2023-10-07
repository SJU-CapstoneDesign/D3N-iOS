//
//  QuestionResultViewModel.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import Combine

public class QuestionResultViewModel: ObservableObject {
    private var subscribers: Set<AnyCancellable> = []
    
    public struct Dependencies: Hashable {
        public let parent: Parent
        public let quizs: [QuizEntity]
        
        public init(
            parent: Parent,
            quizs: [QuizEntity]
        ) {
            self.parent = parent
            self.quizs = quizs
        }
        
        public enum Parent {
            case today
        }
    }
    
    enum Action { 
        case rootButtonTapped
    }
    
    private let dependencies: Dependencies
    private let newsUseCase: NewsUseCaseInterface
    
    public let parent: Dependencies.Parent
    @Published public var quizs: [QuizEntity]
    @Published public var popToRoot: Bool = false
    
    public init(
        dependencies: Dependencies,
        newsUseCase: NewsUseCaseInterface
    ) {
        self.dependencies = dependencies
        self.newsUseCase = newsUseCase
        
        self.parent = dependencies.parent
        self.quizs = dependencies.quizs
        
        bind()
    }
    
    @MainActor
    func send(_ action: Action) {
        switch action {
        case .rootButtonTapped:
            popToRoot = true
        }
    }
    
    func bind() {
        
    }
}

