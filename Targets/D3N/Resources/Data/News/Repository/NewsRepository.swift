//
//  NewsRepository.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import Combine

final class NewsRepository: NewsRepositoryInterface {
    func fetch() async -> Result<[NewsEntity], NewsError> {
        let mock: [NewsResponseDTO] = .init(repeating: NewsResponseDTO.mock, count: 10)
        let newsEntities = mock.map { $0.toDomain() }
        
        return .success(newsEntities)
    }
}
