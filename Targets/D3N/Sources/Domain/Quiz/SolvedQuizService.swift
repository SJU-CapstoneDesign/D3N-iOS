//
//  SolvedQuizService.swift
//  D3N
//
//  Created by Younghoon Ahn on 11/29/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import Moya

public enum SolvedQuizService {
    case fetch
}

extension SolvedQuizService: TargetType {
    public var baseURL: URL { URL(string: Environment.baseURL)! }
    
    public var path: String {
        switch self {
        case .fetch: return "quiz/list/solved"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetch: return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .fetch:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? { nil }
}

