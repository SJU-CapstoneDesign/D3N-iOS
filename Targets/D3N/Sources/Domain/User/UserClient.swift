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
    var onboardNeeded: () async -> Result<Bool, D3NAPIError>
    var onboard: (
        _ nickname: String,
        _ gender: Gender,
        _ birthYear: Int,
        _ categoryList: [NewsField]
    ) async -> Result<UserEntity, D3NAPIError>
}

extension UserClient: TestDependencyKey {
    static let previewValue = Self(
        onboardNeeded: { return .failure(.none) },
        onboard: { nickname, gender, birthYear, categoryList in .failure(.none) }
    )
    
    static let testValue = Self(
        onboardNeeded: unimplemented("\(Self.self).onboardNeeded"),
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
        onboardNeeded: {
            let target: TargetType = UserService.onboardNeeded
            let response: Result<UserOnboardNeededResponseDTO, D3NAPIError> = await D3NAPIkProvider.reqeust(target: target)
            return response.map { dto in
                let entity = dto.isOnBoardingNeeded
                LocalStorageManager.save(.isOnBoardingNeeded, value: entity)
                return entity
            }
        },
        onboard: { nickname, gender, birthYear, categoryList in
            let target: TargetType = UserService.onboard(nickname: nickname, gender: gender, birthYear: birthYear, categoryList: categoryList)
            let response: Result<UserOnboardResponseDTO, D3NAPIError> = await D3NAPIkProvider.reqeust(target: target)
            
            return response.map { dto in
                let entity = dto.toEntity()
                LocalStorageManager.save(.isOnBoardingNeeded, value: false)
                return entity
            }
        }
    )
}
