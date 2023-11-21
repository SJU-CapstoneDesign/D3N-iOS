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
    var fetchNewsList: (Int, Int) async -> Result<[NewsEntity], D3NAPIError>
    var fetchQuizList: (Int) async -> Result<[QuizEntity], D3NAPIError>
}

extension NewsClient: TestDependencyKey {
    static let previewValue = Self(
        fetchNewsList: { _, _ in .failure(.none) },
        fetchQuizList: { _ in .failure(.none) }
    )
    
    static let testValue = Self(
        fetchNewsList: unimplemented("\(Self.self).fetchNewsList"),
        fetchQuizList: unimplemented("\(Self.self).fetchQuizList")
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
        fetchNewsList: { pageIndex, pageSize in
            let target: TargetType = NewsService.fetchNewsList(pageIndex: pageIndex, pageSize: pageSize)
            let response: Result<FetchNewsListResponseDTO, D3NAPIError> = await D3NAPIkProvider.reqeust(target: target)
            
            return response.map(\.content).map { $0.map { $0.toEntity() } }
        },
        fetchQuizList: { newsId in
            let target: TargetType = NewsService.fetchQuizList(newsId: newsId)
            let response: Result<FetchQuizListResponseDTO, D3NAPIError> = await D3NAPIkProvider.reqeust(target: target)
            
            return response.map { $0.map { $0.toEntity() } }
        }
    )
}
