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
        case gptButtonTapped
        case shareButtonTapped
    }
    
    private let dependencies: Dependencies
    private let chatUseCase: ChatUseCaseInterface
    private let pointUseCase: PointUseCaseInterface
    
    public init(
        dependencies: Dependencies,
        chatUseCase: ChatUseCaseInterface,
        pointUseCase: PointUseCaseInterface
    ) {
        self.dependencies = dependencies
        self.chatUseCase = chatUseCase
        self.pointUseCase = pointUseCase
        
        bind()
    }
    
    @MainActor
    func send(_ action: Action) {
        
    }
    
    func bind() {
        
    }
}
