//
//  NewsClient.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture
import Moya

public enum NewsError: Error {
    case no
}

struct NewsClient {
    var fetchTodayNewsList: () async throws -> [NewsEntity]
}

extension NewsClient: TestDependencyKey {
    static let previewValue = Self(
        fetchTodayNewsList: { [] }
    )
    
    static let testValue = Self(
        fetchTodayNewsList: unimplemented("\(Self.self).fetchTodayNewsList")
    )
}

extension DependencyValues {
    var newsClient: NewsClient {
        get { self[NewsClient.self] }
        set { self[NewsClient.self] = newValue }
    }
}

// MARK: - Live API implementation

extension NewsClient: DependencyKey {
    static let liveValue = NewsClient(
        fetchTodayNewsList: {
            let provider = MoyaProvider<NewsService>(plugins: [NetworkLoggerPlugin()])
            let response = await provider.request(.fetchTodayNewsList)
                .map { result in
                    let data = try? JSONDecoder().decode(BaseModel<TodayNewsListResponseDTO>.self, from: result.data)
                    if let dto = data.map(\.result) {
                        return dto?.map { $0.toDomain() } ?? []
                    }
                    return []
                }
            return try response.get()
        }
    )
}
