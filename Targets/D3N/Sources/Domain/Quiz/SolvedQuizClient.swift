//
//  SolvedQuizClient.swift
//  D3N
//
//  Created by Younghoon Ahn on 11/29/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture
import Moya

struct SolvedQuizClient {
    var fetch: (Int) async -> Result<[SolvedQuizEntity], D3NAPIError>
}

extension SolvedQuizClient: TestDependencyKey {
    static let previewValue = Self(
        fetch: { _ in .failure(.none) }
    )
    
    static let testValue = Self(
        fetch: unimplemented("\(Self.self).fetch")
    )
}

extension DependencyValues {
    var solvedQuizClient: SolvedQuizClient {
        get { self[SolvedQuizClient.self] }
    }
}

extension SolvedQuizClient: DependencyKey {
    static let liveValue = SolvedQuizClient(
        fetch: { _ in
            let target: TargetType = SolvedQuizService.fetch
            let response: Result<FetchSolvedQuizListResponseDTO, D3NAPIError> = await D3NAPIkProvider.reqeust(target: target)
            
            return response.map { $0.map { $0.toEntity() } }
        }
    )
}

