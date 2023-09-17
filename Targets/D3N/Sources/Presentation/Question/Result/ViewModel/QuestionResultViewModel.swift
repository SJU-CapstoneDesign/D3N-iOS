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
        public init() { }
    }
    
    enum Action { }
    
    private let dependencies: Dependencies
    private let newsUseCase: NewsUseCaseInterface
    
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
        
    }
    
    func bind() {
        
    }
}

