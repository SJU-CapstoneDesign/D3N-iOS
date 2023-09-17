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
    func fetch() async -> Result<NewsEntity, NewsError> {
        return .success(.init(title: "d", content: "d"))
    }
}
