//
//  NewsUseCase.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public protocol NewsUseCaseInterface {
    func fetch() async -> Result<[NewsEntity], NewsError>
}

public final class NewsUseCase: NewsUseCaseInterface {
    private let newsRepository: NewsRepositoryInterface
    
    public init(
        newsRepository: NewsRepositoryInterface
    ) {
        self.newsRepository = newsRepository
    }
    
    public func fetch() async -> Result<[NewsEntity], NewsError> {
        return await newsRepository.fetch()
    }
}
