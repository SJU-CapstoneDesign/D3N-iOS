//
//  AuthService.swift
//  D3N
//
//  Created by 송영모 on 11/3/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import Moya

public enum AuthService {
    case appleLogin(code: String, idToken: String)
    case appleUnlink
    case refresh
}

extension AuthService: TargetType {
    public var baseURL: URL { URL(string: Environment.baseURL + "/auth")! }
    
    public var path: String {
        switch self {
        case .appleLogin: return "/apple/login"
        case .appleUnlink: return "/apple/unlink"
        case .refresh: return "/refresh"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .appleLogin: return .get
        case .appleUnlink: return .delete
        case .refresh: return .get
        }
    }
    public var task: Task {
        switch self {
        case let .appleLogin(code: code, idToken: idToken):
            return .requestJSONEncodable(AppleLoginRequestDTO(code: code, idToken: idToken))
        case .appleUnlink:
            return .requestPlain
        case .refresh:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return ["Authorization": "Bearer \(LocalStorageManager.load(.accessToken))"]
    }
}
