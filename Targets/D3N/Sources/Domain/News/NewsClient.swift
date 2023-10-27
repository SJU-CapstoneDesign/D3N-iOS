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

public enum NewsError: Error, Equatable {
    case no
}

struct NewsClient {
    var fetchNewsList: (Int, Int) async -> Result<[NewsEntity], NewsError>
    var fetchQuizList: (Int) async -> Result<[QuizEntity], NewsError>
}

extension NewsClient: TestDependencyKey {
    static let previewValue = Self(
        fetchNewsList: { _, _ in .failure(.no) },
        fetchQuizList: { _ in .failure(.no) }
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

// MARK: - Live API implementation

extension NewsClient: DependencyKey {
    static let liveValue = NewsClient(
        fetchNewsList: { pageIndex, pageSize in
            let provider = MoyaProvider<NewsService>(plugins: [NetworkLoggerPlugin()])
            let response = await provider.request(.fetchNewsList(pageIndex: pageIndex, pageSize: pageSize))
            switch response {
            case .success(let success):
                let model = try? JSONDecoder().decode(PageModel<NewsDTO>.self, from: success.data)
                let news = model.map(\.result)?.map(\.content)?.map { $0.toDomain() } ?? []
                return .success(news)
            case .failure(let failure):
                return .failure(.no)
            }
        },
        fetchQuizList: { newsId in
            let provider = MoyaProvider<NewsService>(plugins: [NetworkLoggerPlugin()])
            let response = await provider.request(.fetchQuizList(newsId: newsId))
            switch response {
            case .success(let success):
                let model = try? JSONDecoder().decode(BaseModel<[QuizDTO]>.self, from: success.data)
                let quizs = model.flatMap(\.result)?.compactMap { $0.toDomain() } ?? []
                return .success(quizs)
            case .failure(let failure):
                return .failure(.no)
            }
        }
    )
}
