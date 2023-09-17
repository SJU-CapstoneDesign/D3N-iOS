//
//  QuestionPassageViewModel.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import Combine

public class QuestionPassageViewModel: ObservableObject {
    private var subscribers: Set<AnyCancellable> = []
    
    public struct Dependencies: Hashable {
        public var parent: Parent
        
        public init(parent: Parent) {
            self.parent = parent
        }
        
        public enum Parent {
            case today
        }
    }
    
    enum Action { 
        case nextButtonTapped
    }
    
    public let dependencies: Dependencies
    private let newsUseCase: NewsUseCaseInterface
    
    @Published var questionResultDependenices: QuestionResultViewModel.Dependencies?
    
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
        case .nextButtonTapped:
            questionResultDependenices = .init()
        }
    }
    
    func bind() {
        
    }
}

