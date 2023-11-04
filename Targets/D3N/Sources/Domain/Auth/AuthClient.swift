//
//  AuthClient.swift
//  D3N
//
//  Created by 송영모 on 11/3/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

import ComposableArchitecture
import Moya

struct AuthClient {
    var appleLogin: (_ code: String, _ idToken: String) async -> Result<AuthEntity, D3NAPIError>
    var appleUnlink: () async -> Result<AuthEntity, Error>
    var refresh: () async -> Result<AuthEntity, Error>
}

extension AuthClient: TestDependencyKey {
    static let previewValue = Self(
        appleLogin: { code, idToken in
            return .success(.init(accessToken: "", refreshToken: ""))
        },
        appleUnlink: { .init(.success(.init(accessToken: "", refreshToken: ""))) },
        refresh: { .init(.success(.init(accessToken: "", refreshToken: ""))) }
    )
    
    static let testValue = Self(
        appleLogin: unimplemented("\(Self.self).appleLogin"),
        appleUnlink: unimplemented("\(Self.self).appleUnlink"),
        refresh: unimplemented("\(Self.self).refresh")
    )
}

extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}

// MARK: - Live API implementation

extension AuthClient: DependencyKey {
    static let liveValue = AuthClient(
        appleLogin: { code, idToken in
            let target: TargetType = AuthService.appleUnlink
            let response: Result<AppleLoginResponseDTO, D3NAPIError> = await D3NAPIkProvider.reqeust(target: target)
            return response.map { $0.toEntity() }
        },
        appleUnlink: {
            return .success(.init(accessToken: "", refreshToken: ""))
            
        },
        refresh: {
            return .success(.init(accessToken: "", refreshToken: ""))
        }
    )
}
