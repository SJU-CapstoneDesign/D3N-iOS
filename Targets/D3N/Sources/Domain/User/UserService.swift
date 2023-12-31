//
//  UserService.swift
//  D3N
//
//  Created by 송영모 on 11/6/23.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation
import Moya

public enum UserService {
    case onboardNeeded
    case onboard(nickname: String, gender: Gender, birthDay: Date, newsFields: [NewsField])
}

extension UserService: TargetType {
    public var baseURL: URL { URL(string: Environment.baseURL)! }
    
    public var path: String {
        switch self {
        case .onboardNeeded: return "user/onboard/needed"
        case .onboard: return "user/onboard"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .onboardNeeded: return .get
        case .onboard: return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .onboardNeeded:
            return .requestPlain
            
        case let .onboard(nickname: nickname, gender: gender, birthDay: birthDay, newsFields: newsFields):
            let dto = UserOnboardRequestDTO(
                nickname: nickname,
                gender: gender,
                birthDay: birthDay.timeIntervalSince1970,
                newsFields: newsFields
            )
            return .requestJSONEncodable(dto)
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
}
