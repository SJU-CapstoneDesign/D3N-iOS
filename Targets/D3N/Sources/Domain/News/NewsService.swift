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
    case fetchTodayNewsList
}

extension NewsService: TargetType {
    public var baseURL: URL { URL(string: Environment.baseURL)! }
    
    public var path: String {
        switch self {
        case .fetchTodayNewsList:
            return "/api/v1/news/list/today"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .fetchTodayNewsList:
            return .get
        }
    }
    public var task: Task {
        switch self {
        case .fetchTodayNewsList:
            return .requestPlain
        }
    }
    public var sampleData: Data {
        switch self {
        case .fetchTodayNewsList:
            return "{\"id\": \(""), \"first_name\": \"\("")\", \"last_name\": \"\("")\"}".utf8Encoded
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
