//
//  QuizService.swift
//  D3N
//
//  Created by 송영모 on 11/20/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import Moya

public enum QuizService {
    case fetch(newsId: Int)
    case fetchSolved(newsId: Int)
    case submit(quizs: [QuizEntity])
    case updateTime(quizId: Int, secondTime: Int)
}

extension QuizService: TargetType {
    public var baseURL: URL { URL(string: Environment.baseURL)! }
    
    public var path: String {
        switch self {
        case .fetch: return "quiz/list"
        case .fetchSolved: return "quiz/list/solved"
        case .submit: return "quiz/list/submit"
        case .updateTime: return "quiz/time"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetch: return .get
        case .fetchSolved: return .get
        case .submit: return .post
        case .updateTime: return .patch
        }
    }
    
    public var task: Task {
        switch self {
        case let .fetch(newsId: id):
            return .requestParameters(parameters: ["newsId": id], encoding: URLEncoding.queryString)
        case let .fetchSolved(newsId: id):
            return .requestParameters(parameters: ["newsId": id], encoding: URLEncoding.queryString)
        case let .submit(quizs):
            let dto: SubmitQuizListRequestDTO = quizs.compactMap {
                if let userAnswer = $0.selectedAnswer {
                    return .init(quizId: $0.id, selectedAnswer: userAnswer)
                } else {
                    return nil
                }
            }
            return .requestJSONEncodable(dto)
            
        case let .updateTime(quizId: id, secondTime: time):
            let dto: UpdateQuizTimeRequestDTO = .init(quizId: id, secondTime: time)
            return .requestJSONEncodable(dto)
        }
    }
    
    public var headers: [String: String]? { nil }
}
