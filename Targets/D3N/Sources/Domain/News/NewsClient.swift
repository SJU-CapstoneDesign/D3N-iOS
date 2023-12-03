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

struct NewsClient {
    var fetch: (Int, Int) async -> Result<[NewsEntity], D3NAPIError>
    var fetchToday: () async -> Result<[TodayNewsEntity], D3NAPIError>
    var updateTime: (Int, Int) async -> Result<Bool, D3NAPIError>
}

extension NewsClient: TestDependencyKey {
    static let previewValue = Self(
        fetch: { _, _ in .failure(.none) },
        fetchToday: { .failure(.none) },
        updateTime: { _, _ in .failure(.none) }
    )
    
    static let testValue = Self(
        fetch: unimplemented("\(Self.self).fetch"),
        fetchToday: unimplemented("\(Self.self).fetchToday"),
        updateTime: unimplemented("\(Self.self).updateTime")
    )
}

extension DependencyValues {
    var newsClient: NewsClient {
        get { self[NewsClient.self] }
        set { self[NewsClient.self] = newValue }
    }
}


extension NewsClient: DependencyKey {
    static let liveValue = NewsClient(
        fetch: { pageIndex, pageSize in
            let target: TargetType = NewsService.fetchNewsList(pageIndex: pageIndex, pageSize: pageSize)
            let response: Result<FetchNewsListResponseDTO, D3NAPIError> = await D3NAPIProvider.reqeust(target: target)
            
            return response.map(\.content).map { $0.map { $0.toEntity() } }
        },
        fetchToday: {
            let target: TargetType = NewsService.fetchTodayNewsList
            let response: Result<FetchTodayNewsListResponseDTO, D3NAPIError> = await D3NAPIProvider.reqeust(target: target)
            
            return response.map { $0.map { $0.toEntity() } }
        },
        updateTime: { newsId, secondTime in
            let target: TargetType = NewsService.updateNewsTime(newsId: newsId, secondTime: secondTime)
            let response: Result<UpdateNewsTimeResponseDTO, D3NAPIError> = await D3NAPIProvider.reqeust(target: target)
            
            return response.map { _ in
                return true
            }
        }
    )
}
