//
//  UserClient.swift
//  D3N
//
//  Created by 송영모 on 11/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture
import Moya

struct UserClient {
    var onboard: (
        _ nickname: String,
        _ gender: Gender,
        _ birthYear: Int,
        _ categoryList: [NewsField]
    ) async -> Result<UserEntity, D3NAPIError>
}

extension UserClient: TestDependencyKey {
    static let previewValue = Self(
        onboard: { nickname, gender, birthYear, categoryList in .failure(.none) }
    )
    
    static let testValue = Self(
        onboard: unimplemented("\(Self.self).onboard")
    )
}

extension DependencyValues {
    var userClient: UserClient {
        get { self[UserClient.self] }
        set { self[UserClient.self] = newValue }
    }
}

extension UserClient: DependencyKey {
    static let liveValue = UserClient(
        onboard: { nickname, gender, birthYear, categoryList in
            let target: TargetType = UserService.onboard(nickname: nickname, gender: gender, birthYear: birthYear, categoryList: categoryList)
            let response: Result<UserOnboardResponseDTO, D3NAPIError> = await D3NAPIkProvider.reqeust(target: target)
            return response.map { $0.toEntity() }
        }
    )
}
