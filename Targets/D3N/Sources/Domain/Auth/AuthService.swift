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
    case userOnboard(nickname: String, gender: Gender, birthYear: Int, categoryList: [NewsField])
}

extension AuthService: TargetType {
    public var baseURL: URL { URL(string: Environment.baseURL)! }
    
    public var path: String {
        switch self {
        case .appleLogin: return "auth/apple/login"
        case .appleUnlink: return "auth/apple/unlink"
        case .refresh: return "auth/refresh"
        case .userOnboard: return "user/onboard"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .appleLogin: return .post
        case .appleUnlink: return .delete
        case .refresh: return .get
        case .userOnboard: return .post
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
        case let .userOnboard(nickname: nickname, gender: gender, birthYear: birthYear, categoryList: categoryList):
            return .requestJSONEncodable(UserOnboardRequestDTO(nickname: nickname, gender: gender, birthYear: birthYear, categoryList: categoryList))
        }
    }
    
    public var headers: [String: String]? {
        return ["Authorization": "Bearer \(LocalStorageManager.load(.accessToken))"]
    }
}
