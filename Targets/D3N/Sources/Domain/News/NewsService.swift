//
//  NewsService.swift
//  D3N
//
//  Created by 송영모 on 10/12/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import Moya

public enum NewsService {
    case fetchNewsList(pageIndex: Int,pageSize: Int)
    case fetchQuizList(newsId: Int)
}

extension NewsService: TargetType {
    public var baseURL: URL { URL(string: Environment.baseURL)! }
    
    public var path: String {
        switch self {
        case .fetchNewsList:
            return "/api/v1/news/list"
        case .fetchQuizList:
            return "/api/v1/quiz/list"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .fetchNewsList, .fetchQuizList:
            return .get
        }
    }
    public var task: Task {
        switch self {
        case let .fetchNewsList(pageIndex: page, pageSize: size):
            return .requestParameters(parameters: ["pageIndex": page, "pageSize": size], encoding: URLEncoding.queryString)
        case let .fetchQuizList(newsId: id):
            return .requestParameters(parameters: ["newsId": id], encoding: URLEncoding.queryString)
        }
    }
    public var sampleData: Data {
        switch self {
        case .fetchNewsList:
            return "".utf8Encoded
        case .fetchQuizList:
            return "".utf8Encoded
        }
    }
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}
