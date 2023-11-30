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
    case fetchTodayNewsList
    case updateNewsTime(newsId: Int, secondTime: Int)
}

extension NewsService: TargetType {
    public var baseURL: URL { URL(string: Environment.baseURL)! }
    
    public var path: String {
        switch self {
        case .fetchNewsList: return "news/list"
        case .fetchTodayNewsList: return "news/today/list"
        case .updateNewsTime: return "news/time"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchNewsList: return .get
        case .fetchTodayNewsList: return .get
        case .updateNewsTime: return .patch
        }
    }
    
    public var task: Task {
        switch self {
        case let .fetchNewsList(pageIndex: page, pageSize: size):
            return .requestParameters(parameters: ["pageIndex": page, "pageSize": size], encoding: URLEncoding.queryString)
        case .fetchTodayNewsList:
            return .requestPlain
        case let .updateNewsTime(newsId: id, secondTime: time):
            let dto = UpdateNewsTimeRequestDTO(newsId: id, secondTime: time)
            return .requestJSONEncodable(dto)
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
}
