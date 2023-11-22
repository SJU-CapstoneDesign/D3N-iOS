//
//  QuizClient.swift
//  D3N
//
//  Created by 송영모 on 11/20/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture
import Moya

struct QuizClient {
    var fetch: (Int) async -> Result<[QuizEntity], D3NAPIError>
    var submit: ([QuizEntity]) async -> Result<[Int], D3NAPIError>
}

extension QuizClient: TestDependencyKey {
    static let previewValue = Self(
        fetch: { _ in .failure(.none) },
        submit: { _ in .failure(.none) }
    )
    
    static let testValue = Self(
        fetch: unimplemented("\(Self.self).fetch"),
        submit: unimplemented("\(Self.self).submit")
    )
}

extension DependencyValues {
    var quizClient: QuizClient {
        get { self[QuizClient.self] }
        set { self[QuizClient.self] = newValue }
    }
}

extension QuizClient: DependencyKey {
    static let liveValue = QuizClient(
        fetch: { newsId in
            let target: TargetType = NewsService.fetchQuizList(newsId: newsId)
            let response: Result<FetchQuizListResponseDTO, D3NAPIError> = await D3NAPIkProvider.reqeust(target: target)
            
            return response.map { $0.map { $0.toEntity() } }
        },
        submit: { quizs in
            let target: TargetType = QuizService.submit(quizs: quizs)
            let response: Result<SubmitQuizListResponseDTO, D3NAPIError> = await D3NAPIkProvider.reqeust(target: target)
            
            return response.map {
                $0.map { $0.quizId }
            }
        }
    )
}