//
//  QuestionPassageViewModel.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

public class QuestionPassageViewModel: ObservableObject {
    private var subscribers: Set<AnyCancellable> = []
    
    public struct Dependencies: Hashable {
        public let parent: Parent
        public let news: NewsEntity
        
        public init(
            parent: Parent,
            news: NewsEntity
        ) {
            self.parent = parent
            self.news = news
        }
        
        public enum Parent {
            case today
        }
    }
    
    enum Action { 
        case nextButtonTapped
        case questionButtonTapped
    }
    
    public let dependencies: Dependencies
    private let newsUseCase: NewsUseCaseInterface
    
    @Published public var news: NewsEntity
    @Published public var isShowQuestionBottomSheet: Bool = false

    @Published var questionResultDependenices: QuestionResultViewModel.Dependencies?
    
    public init(
        dependencies: Dependencies,
        newsUseCase: NewsUseCaseInterface
    ) {
        self.dependencies = dependencies
        self.newsUseCase = newsUseCase
        
        self.news = dependencies.news
        
        bind()
    }
    
    @MainActor
    func send(_ action: Action) {
        switch action {
        case .nextButtonTapped:
            isShowQuestionBottomSheet = false
            questionResultDependenices = .init(.init(parent: .today, quizs: news.quizs))
            
        case .questionButtonTapped:
            isShowQuestionBottomSheet = true
        }
    }
    
    func bind() {
        
    }
}

